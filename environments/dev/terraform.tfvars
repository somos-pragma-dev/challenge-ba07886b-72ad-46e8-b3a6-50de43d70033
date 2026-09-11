# Configuración de desarrollo - Environment de desarrollo para pruebas iniciales
# Settings: Desarrollo temprano, menor escala, costos optimizados

environment = "dev"
environment_short = "d"

# Configuración de la VPC
vpc_cidr = "10.100.0.0/16"
vpc_name = "pagos-dev-vpc"
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de Availability Zones (dev usa 2 AZs para reducir costos)
availability_zones = ["us-east-1a", "us-east-1b"]

# Subredes públicas - Para ALB, NAT Gateway, servicios que necesitan internet pública
public_subnet_cidrs = ["10.100.1.0/24", "10.100.2.0/24"]
public_subnet_names = ["pagos-dev-pub-us-east-1a", "pagos-dev-pub-us-east-1b"]
map_public_ip_on_launch = true

# Subredes privadas para aplicaciones - Backend de la aplicación
app_subnet_cidrs = ["10.100.10.0/24", "10.100.11.0/24"]
app_subnet_names = ["pagos-dev-priv-app-us-east-1a", "pagos-dev-priv-app-us-east-1b"]

# Subredes privadas para datos - Databases y sistemas de almacenamiento
data_subnet_cidrs = ["10.100.20.0/24", "10.100.21.0/24"]
data_subnet_names = ["pagos-dev-priv-data-us-east-1a", "pagos-dev-priv-data-us-east-1b"]

# Subredes privadas para servicios de pago - Gateway de pagos, liquidación, antifraude
payment_subnet_cidrs = ["10.100.30.0/24", "10.100.31.0/24"]
payment_subnet_names = ["pagos-dev-priv-payment-us-east-1a", "pagos-dev-priv-payment-us-east-1b"]

# Configuración de NAT Gateway (alta disponibilidad en producción, mínimo en dev)
nat_gateway_count = 1
nat_gateway_type = "single"

# Configuración de Internet Gateway
enable_internet_gateway = true

# Configuración de VPN/Direct Connect (no necesario en dev)
enable_vpn_gateway = false

# Configuración de seguridad - Grupos de seguridad
# ALB público - Expuesto a internet para pruebas
alb_security_group_name = "pagos-dev-alb-public-sg"
alb_port = 443
alb_protocol = "HTTPS"

# Security group para aplicación
app_security_group_name = "pagos-dev-app-sg"
app_allow_ports = [443, 8080]
app_protocol = "tcp"

# Security group para base de datos
database_security_group_name = "pagos-dev-db-sg"
db_port = 5432
db_protocol = "tcp"
db_allow_cidrs = ["10.100.10.0/24", "10.100.30.0/24"]

# Security group para servicios de pago
payment_security_group_name = "pagos-dev-payment-sg"
payment_port = 8443
payment_protocol = "tcp"
payment_allow_cidrs = ["10.100.10.0/24"]

# Configuración de IAM - Roles con menor privilegio
# Rol para EC2 de aplicación
app_iam_role_name = "pagos-dev-app-ec2-role"
app_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "s3:ListBucket",
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "cloudwatch:PutMetricData",
  "logs:CreateLogGroup",
  "logs:PutLogEvents"
]

# Rol para servicios de pago
payment_iam_role_name = "pagos-dev-payment-role"
payment_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:GenerateDataKey",
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query"
]

# Configuración de logging y monitoreo
enable_vpc_flow_logs = true
flow_log_destination_type = "cloud-watch-logs"
log_retention_days = 7

# Alarmas CloudWatch - Configuración básica para dev
enable_alarms = true
alarm_cpu_threshold = 80
alarm_memory_threshold = 85
alarm_http_5xx_threshold = 5

# Configuración de alta disponibilidad
# Dev usa menor redundancia para optimizar costos
multi_az = false
instance_tenancy = "default"

# Configuración de escalado (dev usa configuración básica)
asg_min_size = 1
asg_max_size = 2
asg_desired_capacity = 1
asg_health_check_type = "ELB"
asg_health_check_grace_period = 300

# Configuración de almacenamiento
root_volume_size = 30
root_volume_type = "gp3"
data_volume_size = 100
data_volume_type = "gp3"

# Configuración de red avanzada
enable_transit_gateway = false
enable_private_link = false

# Tags obligatorios para todos los recursos
common_tags = {
  Environment = "development"
  Project = "pagos-seguro"
  CostCenter = "it-operations"
  Compliance = "pci-dss"
  ManagedBy = "terraform"
  Owner = "cloudops-team"
}