# Configuración de Producción - Environment de producción para sistema de pagos
# Settings: Alta disponibilidad, máximo rendimiento, cumplimiento PCI-DSS

environment = "prod"
environment_short = "p"

# Configuración de la VPC
vpc_cidr = "10.102.0.0/16"
vpc_name = "pagos-prod-vpc"
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de Availability Zones - 3 AZs para máxima disponibilidad
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Subredes públicas - Distribuidas en 3 AZs
public_subnet_cidrs = ["10.102.1.0/24", "10.102.2.0/24", "10.102.3.0/24"]
public_subnet_names = ["pagos-prod-pub-us-east-1a", "pagos-prod-pub-us-east-1b", "pagos-prod-pub-us-east-1c"]
map_public_ip_on_launch = true

# Subredes privadas para aplicaciones - 3 AZs
app_subnet_cidrs = ["10.102.10.0/24", "10.102.11.0/24", "10.102.12.0/24"]
app_subnet_names = ["pagos-prod-priv-app-us-east-1a", "pagos-prod-priv-app-us-east-1b", "pagos-prod-priv-app-us-east-1c"]

# Subredes privadas para datos - 3 AZs con replicación
data_subnet_cidrs = ["10.102.20.0/24", "10.102.21.0/24", "10.102.22.0/24"]
data_subnet_names = ["pagos-prod-priv-data-us-east-1a", "pagos-prod-priv-data-us-east-1b", "pagos-prod-priv-data-us-east-1c"]

# Subredes privadas para servicios de pago - Aislamiento total
payment_subnet_cidrs = ["10.102.30.0/24", "10.102.31.0/24", "10.102.32.0/24"]
payment_subnet_names = ["pagos-prod-priv-payment-us-east-1a", "pagos-prod-priv-payment-us-east-1b", "pagos-prod-priv-payment-us-east-1c"]

# Subred dedicada para motor antifraude - Procesamiento crítico
fraud_subnet_cidrs = ["10.102.40.0/24", "10.102.41.0/24", "10.102.42.0/24"]
fraud_subnet_names = ["pagos-prod-priv-fraud-us-east-1a", "pagos-prod-priv-fraud-us-east-1b", "pagos-prod-priv-fraud-us-east-1c"]

# Subred para sistema de liquidación
settlement_subnet_cidrs = ["10.102.50.0/24", "10.102.51.0/24", "10.102.52.0/24"]
settlement_subnet_names = ["pagos-prod-priv-settlement-us-east-1a", "pagos-prod-priv-settlement-us-east-1b", "pagos-prod-priv-settlement-us-east-1c"]

# NAT Gateway - Alta disponibilidad con redundancia completa
nat_gateway_count = 3
nat_gateway_type = "redundant-one-per-az"
nat_eip_allocation = true

# Internet Gateway -冗余配置
enable_internet_gateway = true
igw_redundant = true

# VPN y Direct Connect para conectividad híbrida
enable_vpn_gateway = true
vpn_connection_type = "ipsec.1"
vpn_tunnel_options = {
  tunnel1 = { encryption = "AES256", integrity = "SHA256", pre_shared_key = "dynamic" }
  tunnel2 = { encryption = "AES256", integrity = "SHA256", pre_shared_key = "dynamic" }
}
enable_direct_connect = true
direct_connect_location = "eqdc"

# Security Groups - Máxima restricción
alb_security_group_name = "pagos-prod-alb-public-sg"
alb_port = 443
alb_protocol = "HTTPS"
alb_ssl_policy = "ELBSecurityPolicy-TLS-1-2-2021-07"
alb_access_logging = true
alb_deletion_protection = true

app_security_group_name = "pagos-prod-app-sg"
app_allow_ports = [443, 8443]
app_protocol = "tcp"
app_allow_from_security_groups = ["pagos-prod-alb-public-sg"]
app_intra_vpc_restricted = true

database_security_group_name = "pagos-prod-db-sg"
db_port = 5432
db_protocol = "tcp"
db_allow_cidrs = []
db_allow_from_security_groups = ["pagos-prod-app-sg", "pagos-prod-payment-sg", "pagos-prod-fraud-sg"]
db_encryption_enabled = true
db_audit_logging = true

payment_security_group_name = "pagos-prod-payment-sg"
payment_port = 8443
payment_protocol = "tcp"
payment_allow_cidrs = ["10.102.10.0/24"]
payment_allow_from_security_groups = ["pagos-prod-app-sg"]
payment_strict_mode = true

fraud_security_group_name = "pagos-prod-fraud-sg"
fraud_port = 8080
fraud_protocol = "tcp"
fraud_allow_cidrs = ["10.102.10.0/24", "10.102.30.0/24"]
fraud_allow_from_security_groups = ["pagos-prod-app-sg", "pagos-prod-payment-sg"]

settlement_security_group_name = "pagos-prod-settlement-sg"
settlement_port = 8080
settlement_protocol = "tcp"
settlement_allow_from_security_groups = ["pagos-prod-payment-sg"]

# IAM - Principio de menor privilegio estricto con permisos específicos por recurso
app_iam_role_name = "pagos-prod-app-ec2-role"
app_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject"
]
app_iam_resource_arns = [
  "arn:aws:s3:::pagos-prod-data/*",
  "arn:aws:s3:::pagos-prod-data",
  "arn:aws:dynamodb:us-east-1:123456789012:table/pagos-prod-transactions"
]
app_iam_condition_keys = ["aws:RequestedRegion", "aws:PrincipalAccount"]

payment_iam_role_name = "pagos-prod-payment-role"
payment_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:GenerateDataKey*"
]
payment_iam_resource_arns = [
  "arn:aws:s3:::pagos-prod-pci/*",
  "arn:aws:s3:::pagos-prod-pci",
  "arn:aws:kms:us-east-1:123456789012:key/pagos-prod-master-key",
  "arn:aws:dynamodb:us-east-1:123456789012:table/pagos-prod-sensitive"
]
payment_iam_condition_keys = ["aws:RequestedRegion", "aws:PrincipalAccount", "aws:PrincipalTag/Department"]

fraud_iam_role_name = "pagos-prod-fraud-role"
fraud_iam_policy_actions = [
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "kinesis:GetRecords*"
]
fraud_iam_resource_arns = [
  "arn:aws:dynamodb:us-east-1:123456789012:table/pagos-prod-fraud*",
  "arn:aws:kinesis:us-east-1:123456789012:stream/pagos-prod-fraud-stream"
]

settlement_iam_role_name = "pagos-prod-settlement-role"
settlement_iam_policy_actions = [
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "s3:GetObject",
  "s3:PutObject",
  "sqs:ReceiveMessage",
  "sqs:DeleteMessage"
]
settlement_iam_resource_arns = [
  "arn:aws:dynamodb:us-east-1:123456789012:table/pagos-prod-settlement*",
  "arn:aws:s3:::pagos-prod-settlement/*",
  "arn:aws:sqs:us-east-1:123456789012:pagos-prod-settlement-queue"
]

# Configuración de logging - Completa con auditoría
enable_vpc_flow_logs = true
flow_log_destination_type = "cloud-watch-logs"
log_retention_days = 90
log_file_format = "parquet"
log_compression = "gzip"
flow_log_max_aggregation_interval = 60

# CloudWatch - Monitoreo completo con métricas personalizadas
enable_alarms = true
alarm_cpu_threshold = 70
alarm_memory_threshold = 75
alarm_http_5xx_threshold = 1
alarm_http_4xx_threshold = 10
alarm_latency_p95_threshold = 200
alarm_latency_p99_threshold = 500
alarm_retry_count_threshold = 2
alarm_queue_depth_threshold = 1000
alarm_connection_errors_threshold = 5
alarm_sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:pagos-prod-alarms"
alarm_escalation_policy = "pagos-oncall"

# Alta disponibilidad - Configuración completa
multi_az = true
instance_tenancy = "dedicated"
enable_aurora_multi_az = true
rds_backup_retention_days = 30
rds_delete_protection = true

# Auto Scaling - Configuración dinámica
asg_min_size = 3
asg_max_size = 10
asg_desired_capacity = 5
asg_health_check_type = "ELB"
asg_health_check_grace_period = 120
asg_cooldown_period = 180
asg_scale_up_threshold = 60
asg_scale_down_threshold = 25
asg_predictive_scaling = true
asg_target_value = 70

# Almacenamiento - Cifrado y rendimiento
root_volume_size = 80
root_volume_type = "gp3"
root_volume_iops = 3000
data_volume_size = 500
data_volume_type = "gp3"
data_volume_iops = 10000
enable_ebs_encryption = true
kms_key_id = "alias/pagos-prod-ebs"

# Configuración de red avanzada - Transit Gateway y PrivateLink
enable_transit_gateway = true
transit_gateway_asn = 64512
transit_gateway_route_tables = {
  spoke = "pagos-prod-spoke-rt"
  shared = "pagos-prod-shared-rt"
}
enable_private_link = true
endpoints = [
  "s3",
  "dynamodb",
  "secretsmanager",
  "sqs",
  "sns",
  "kms",
  "cloudwatch",
  "logs"
]

# DDoS y WAF
enable_shield_advanced = true
enable_waf = true
waf_rules = [
  "AWSManagedRulesCommonRuleSet",
  "AWSManagedRulesSQLiRuleSet",
  "AWSManagedRulesKnownBadInputsRuleSet"
]
waf_rate_limit = 1000

# Backup y recuperación
enable_backup = true
backup_plan = "pagos-prod-daily"
backup_copies = 3
backup_cold_storage = true
backup_retention_days = 2555

# Tags - Cumplimiento PCI-DSS
common_tags = {
  Environment = "production"
  Project = "pagos-seguro"
  CostCenter = "it-operations"
  Compliance = "pci-dss"
  ManagedBy = "terraform"
  Owner = "cloudops-team"
  DataClassification = "confidential"
  BackupRequired = "true"
  DRTier = "1"
  RTO = "15m"
  RPO = "5m"
}