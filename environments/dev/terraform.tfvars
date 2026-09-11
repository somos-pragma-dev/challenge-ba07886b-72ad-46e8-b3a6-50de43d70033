# =============================================================================
# Configuración del entorno de DESARROLLO
# =============================================================================
# Este archivo contiene los valores de variables específicos para el ambiente
# de desarrollo. Los valores están optimizados para pruebas locales y costos
# mínimos, con instancias pequeñas y sin redundancia multi-AZ.
# =============================================================================

# -----------------------------------------------------------------------------
# Configuración de Red - VPC y Subredes
# -----------------------------------------------------------------------------
environment               = "dev"
environment_short         = "d"
vpc_cidr                  = "10.0.0.0/16"

# Subredes públicas - Monitoreo y auditoría (una sola AZ para dev)
public_subnet_1_cidr      = "10.0.1.0/24"
public_subnet_2_cidr      = "10.0.2.0/24"
availability_zone_1       = "us-east-1a"
availability_zone_2       = "us-east-1b"

# Subredes privadas - Servicios de pago (una sola AZ para dev)
private_subnet_pagos_1_cidr   = "10.0.10.0/24"
private_subnet_pagos_2_cidr   = "10.0.11.0/24"
private_subnet_antifraude_1_cidr = "10.0.20.0/24"
private_subnet_antifraude_2_cidr = "10.0.21.0/24"
private_subnet_buro_1_cidr    = "10.0.30.0/24"
private_subnet_buro_2_cidr    = "10.0.31.0/24"
private_subnet_liquidacion_1_cidr = "10.0.40.0/24"
private_subnet_liquidacion_2_cidr = "10.0.41.0/24"

# NAT Gateway - Una sola instancia para desarrollo
enable_nat_gateway        = true
single_nat_gateway        = true

# -----------------------------------------------------------------------------
# Configuración de Servicios - Instancias pequeñas para desarrollo
# -----------------------------------------------------------------------------

# RDS - Base de datos de pagos (instancia pequeña, sin réplicas)
rds_instance_class       = "db.t3.micro"
rds_allocated_storage    = 20
rds_multi_az              = false
rds_engine_version        = "15.4"

# Lambda - Funciones serverless para procesamiento de pagos
lambda_memory_sizes = {
  originador_pagos   = 128
  motor_antifraude   = 256
  buro_riesgos       = 128
  sistema_liquidacion = 256
}

lambda_timeout = {
  originador_pagos   = 30
  motor_antifraude   = 60
  buro_riesgos       = 30
  sistema_liquidacion = 120
}

# ALB - Balanceador de carga (instancia pequeña)
alb_type                = "application"
alb_enable_deletion_protection = false
alb_idle_timeout        = 60

# -----------------------------------------------------------------------------
# Configuración de Seguridad - Políticas restrictivas para dev
# -----------------------------------------------------------------------------

# KMS - Cifrado
kms_key_administrators = ["arn:aws:iam::123456789012:user/dev-admin"]
kms_key_users          = ["arn:aws:iam::123456789012:user/dev-user"]
enable_kms_rotation    = false

# IAM - Roles con permisos mínimos para desarrollo
iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/dev-permissions-boundary"

# Security Groups - Puertos restringidos para dev
allowed_ssh_cidrs       = ["10.0.0.0/16"]
allowed_https_cidrs     = ["0.0.0.0/0"]
allowed_mgmt_cidrs      = ["10.0.0.0/16"]

# -----------------------------------------------------------------------------
# Etiquetas obligatorias para optimización de costos
# -----------------------------------------------------------------------------
tags = {
  Environment     = "dev"
  CostCenter      = "pagos-dev"
  Owner           = "equipo-pagos"
  Project         = "red-pagos-segura"
  Compliance      = "PCI-DSS"
  Monitoring      = "enabled"
  Backup          = "daily"
}

# -----------------------------------------------------------------------------
# Configuración de Observabilidad
# -----------------------------------------------------------------------------
alarm_email              = "dev-alerts@empresa.com"
log_retention_days      = 7
enable_vpc_flow_logs    = false
enable_cloudwatch_logs  = true

# -----------------------------------------------------------------------------
# Configuración de Alta Disponibilidad (reducida para dev)
# -----------------------------------------------------------------------------
enable_deletion_protection = false
backup_retention_days   = 7
rto_minutes             = 60
rpo_minutes             = 30