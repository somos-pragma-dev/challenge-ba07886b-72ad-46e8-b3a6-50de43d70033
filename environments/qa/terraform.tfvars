# Configuración de QA - Environment de pruebas de integración y QA
# Settings: Pruebas funcionales, mayor escala que dev, validación de seguridad

environment = "qa"
environment_short = "q"

# Configuración de la VPC
vpc_cidr = "10.101.0.0/16"
vpc_name = "pagos-qa-vpc"
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de Availability Zones (QA usa 2 AZs para balance costo/rendimiento)
availability_zones = ["us-east-1a", "us-east-1b"]

# Subredes públicas
public_subnet_cidrs = ["10.101.1.0/24", "10.101.2.0/24"]
public_subnet_names = ["pagos-qa-pub-us-east-1a", "pagos-qa-pub-us-east-1b"]
map_public_ip_on_launch = true

# Subredes privadas para aplicaciones
app_subnet_cidrs = ["10.101.10.0/24", "10.101.11.0/24"]
app_subnet_names = ["pagos-qa-priv-app-us-east-1a", "pagos-qa-priv-app-us-east-1b"]

# Subredes privadas para datos
data_subnet_cidrs = ["10.101.20.0/24", "10.101.21.0/24"]
data_subnet_names = ["pagos-qa-priv-data-us-east-1a", "pagos-qa-priv-data-us-east-1b"]

# Subredes privadas para servicios de pago - Mayor segmentación en QA
payment_subnet_cidrs = ["10.101.30.0/24", "10.101.31.0/24"]
payment_subnet_names = ["pagos-qa-priv-payment-us-east-1a", "pagos-qa-priv-payment-us-east-1b"]

# Subred dedicada para motor antifraude
fraud_subnet_cidrs = ["10.101.40.0/24", "10.101.41.0/24"]
fraud_subnet_names = ["pagos-qa-priv-fraud-us-east-1a", "pagos-qa-priv-fraud-us-east-1b"]

# NAT Gateway - Alta disponibilidad en QA
nat_gateway_count = 2
nat_gateway_type = "redundant"

# Internet Gateway
enable_internet_gateway = true

# VPN para acceso seguro a QA
enable_vpn_gateway = true
vpn_connection_type = "ipsec.1"

# Security Groups
alb_security_group_name = "pagos-qa-alb-public-sg"
alb_port = 443
alb_protocol = "HTTPS"
alb_ssl_policy = "ELBSecurityPolicy-2016-08"

app_security_group_name = "pagos-qa-app-sg"
app_allow_ports = [443, 8080, 8443]
app_protocol = "tcp"

database_security_group_name = "pagos-qa-db-sg"
db_port = 5432
db_protocol = "tcp"
db_allow_cidrs = ["10.101.10.0/24", "10.101.30.0/24", "10.101.40.0/24"]

payment_security_group_name = "pagos-qa-payment-sg"
payment_port = 8443
payment_protocol = "tcp"
payment_allow_cidrs = ["10.101.10.0/24"]

fraud_security_group_name = "pagos-qa-fraud-sg"
fraud_port = 8080
fraud_protocol = "tcp"
fraud_allow_cidrs = ["10.101.10.0/24", "10.101.30.0/24"]

# IAM - Políticas más restrictivas en QA simulando producción
app_iam_role_name = "pagos-qa-app-ec2-role"
app_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "s3:ListBucket",
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "cloudwatch:PutMetricData",
  "logs:CreateLogGroup",
  "logs:PutLogEvents",
  "secretsmanager:GetSecretValue"
]
app_iam_resource_restrictions = true

payment_iam_role_name = "pagos-qa-payment-role"
payment_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:GenerateDataKey",
  "kms:DescribeKey",
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "dynamodb:BatchGetItem",
  "dynamodb:BatchWriteItem"
]
payment_iam_resource_restrictions = true

fraud_iam_role_name = "pagos-qa-fraud-role"
fraud_iam_policy_actions = [
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "dynamodb:Scan",
  "s3:GetObject",
  "s3:PutObject",
  "kinesis:GetRecords",
  "kinesis:GetShardIterator",
  "kinesis:DescribeStream"
]

# Configuración de logging - Mayor retención en QA
enable_vpc_flow_logs = true
flow_log_destination_type = "cloud-watch-logs"
log_retention_days = 30
log_file_format = "parquet"

# Alarmas CloudWatch - Configuración completa para QA
enable_alarms = true
alarm_cpu_threshold = 75
alarm_memory_threshold = 80
alarm_http_5xx_threshold = 3
alarm_latency_p95_threshold = 500
alarm_retry_count_threshold = 3
alarm_sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:pagos-qa-alarms"

# Alta disponibilidad en QA
multi_az = true
instance_tenancy = "default"

# Auto Scaling Group - Configuración de producción ligera
asg_min_size = 2
asg_max_size = 4
asg_desired_capacity = 2
asg_health_check_type = "ELB"
asg_health_check_grace_period = 300
asg_cooldown_period = 300
asg_scale_up_threshold = 70
asg_scale_down_threshold = 30

# Almacenamiento
root_volume_size = 50
root_volume_type = "gp3"
data_volume_size = 200
data_volume_type = "gp3"
enable_ebs_encryption = true

# Configuración de red avanzada - Preparado para PrivateLink
enable_transit_gateway = false
enable_private_link = true
endpoints = [
  "s3",
  "dynamodb",
  "secretsmanager",
  "sqs",
  "sns"
]

# Tags
common_tags = {
  Environment = "qa"
  Project = "pagos-seguro"
  CostCenter = "it-operations"
  Compliance = "pci-dss"
  ManagedBy = "terraform"
  Owner = "cloudops-team"
  QAValidation = "required"
}