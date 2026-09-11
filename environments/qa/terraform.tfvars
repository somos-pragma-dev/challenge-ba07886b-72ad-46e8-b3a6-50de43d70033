# =============================================================================
# Configuración del entorno de QA
# =============================================================================
# Este archivo contiene los valores de variables específicos para el ambiente
# de QA. Los valores reflejan un ambiente de pruebas más representativo con
# instancias medianas, configuración de seguridad reforzada y capacidad de
# pruebas de carga. Incluye redundancia básica en una zona de disponibilidad.
# =============================================================================

# -----------------------------------------------------------------------------
# Configuración de Red - VPC y Subredes
# -----------------------------------------------------------------------------
environment               = "qa"
environment_short         = "q"
vpc_cidr                  = "10.1.0.0/16"

# Subredes públicas - Monitoreo y auditoría (dos AZ para QA)
public_subnet_1_cidr      = "10.1.1.0/24"
public_subnet_2_cidr      = "10.1.2.0/24"
availability_zone_1       = "us-east-1a"
availability_zone_2       = "us-east-1b"

# Subredes privadas - Servicios de pago (dos AZ para QA)
private_subnet_pagos_1_cidr   = "10.1.10.0/24"
private_subnet_pagos_2_cidr   = "10.1.11.0/24"
private_subnet_antifraude_1_cidr = "10.1.20.0/24"
private_subnet_antifraude_2_cidr = "10.1.21.0/24"
private_subnet_buro_1_cidr    = "10.1.30.0/24"
private_subnet_buro_2_cidr    = "10.1.31.0/24"
private_subnet_liquidacion_1_cidr = "10.1.40.0/24"
private_subnet_liquidacion_2_cidr = "10.1.41.0/24"

# NAT Gateway - Alta disponibilidad en QA (una por AZ)
enable_nat_gateway        = true
single_nat_gateway        = false

# -----------------------------------------------------------------------------
# Configuración de Servicios - Instancias medianas para QA
# -----------------------------------------------------------------------------

# RDS - Base de datos de pagos (instancia mediana, standby en otra AZ)
rds_instance_class       = "db.t3.medium"
rds_allocated_storage    = 50
rds_multi_az              = true
rds_engine_version        = "15.4"

# Lambda - Funciones serverless para procesamiento de pagos
lambda_memory_sizes = {
  originador_pagos   = 256
  motor_antifraude   = 512
  buro_riesgos       = 256
  sistema_liquidacion = 512
}

lambda_timeout = {
  originador_pagos   = 60
  motor_antifraude   = 90
  buro_riesgos       = 60
  sistema_liquidacion = 180
}

# ALB - Balanceador de carga (instancia mediana)
alb_type                = "application"
alb_enable_deletion_protection = true
alb_idle_timeout        = 60

# -----------------------------------------------------------------------------
# Configuración de Seguridad - Políticas más restrictivas para QA
# -----------------------------------------------------------------------------

# KMS - Cifrado con rotación habilitada
kms_key_administrators = ["arn:aws:iam::123456789012:user/qa-admin", "arn:aws:iam::123456789012:role/qa-automation"]
kms_key_users          = ["arn:aws:iam::123456789012:user/qa-user", "arn:aws:iam::123456789012:role/qa-app-role"]
enable_kms_rotation    = true

# IAM - Roles con permisos específicos por servicio
iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/qa-permissions-boundary"

# Security Groups - Puertos más restrictivos para QA
allowed_ssh_cidrs       = ["10.1.0.0/16", "172.16.0.0/12"]
allowed_https_cidrs     = ["10.0.0.0/8"]
allowed_mgmt_cidrs      = ["10.1.0.0/16", "172.16.0.0/12"]

# -----------------------------------------------------------------------------
# Etiquetas obligatorias para optimización de costos
# -----------------------------------------------------------------------------
tags = {
  Environment     = "qa"
  CostCenter      = "pagos-qa"
  Owner           = "equipo-pagos"
  Project         = "red-pagos-segura"
  Compliance      = "PCI-DSS"
  Monitoring      = "enabled"
  Backup          = "daily"
  DataClassification = "confidential"
}

# -----------------------------------------------------------------------------
# Configuración de Observabilidad
# -----------------------------------------------------------------------------
alarm_email              = "qa-alerts@empresa.com"
log_retention_days      = 14
enable_vpc_flow_logs    = true
enable_cloudwatch_logs  = true

# -----------------------------------------------------------------------------
# Configuración de Alta Disponibilidad
# -----------------------------------------------------------------------------
enable_deletion_protection = true
backup_retention_days   = 14
rto_minutes             = 30
rpo_minutes             = 15