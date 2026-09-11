# =============================================================================
# Configuración del entorno de PRODUCCIÓN
# =============================================================================
# Este archivo contiene los valores de variables específicos para el ambiente
# de producción. Los valores están optimizados para alta disponibilidad con
# instancias grandes, redundancia multi-AZ, cifrado obligatorio y todas las
# medidas de seguridad habilitadas. Cumple con los requisitos de 10,000 TPS
# y SLA 99.9% para el sistema de pagos.
# =============================================================================

# -----------------------------------------------------------------------------
# Configuración de Red - VPC y Subredes
# -----------------------------------------------------------------------------
environment               = "prod"
environment_short         = "p"
vpc_cidr                  = "10.2.0.0/16"

# Subredes públicas - Monitoreo y auditoría (tres AZ para alta disponibilidad)
public_subnet_1_cidr      = "10.2.1.0/24"
public_subnet_2_cidr      = "10.2.2.0/24"
public_subnet_3_cidr      = "10.2.3.0/24"
availability_zone_1       = "us-east-1a"
availability_zone_2       = "us-east-1b"
availability_zone_3       = "us-east-1c"

# Subredes privadas - Servicios de pago (tres AZ para producción)
private_subnet_pagos_1_cidr   = "10.2.10.0/24"
private_subnet_pagos_2_cidr   = "10.2.11.0/24"
private_subnet_pagos_3_cidr   = "10.2.12.0/24"
private_subnet_antifraude_1_cidr = "10.2.20.0/24"
private_subnet_antifraude_2_cidr = "10.2.21.0/24"
private_subnet_antifraude_3_cidr = "10.2.22.0/24"
private_subnet_buro_1_cidr    = "10.2.30.0/24"
private_subnet_buro_2_cidr    = "10.2.31.0/24"
private_subnet_buro_3_cidr    = "10.2.32.0/24"
private_subnet_liquidacion_1_cidr = "10.2.40.0/24"
private_subnet_liquidacion_2_cidr = "10.2.41.0/24"
private_subnet_liquidacion_3_cidr = "10.2.42.0/24"

# NAT Gateway - Alta disponibilidad (una por AZ en prod)
enable_nat_gateway        = true
single_nat_gateway        = false

# -----------------------------------------------------------------------------
# Configuración de Servicios - Instancias grandes para producción
# -----------------------------------------------------------------------------

# RDS - Base de datos de pagos (instancia grande, multi-AZ completo)
rds_instance_class       = "db.r6g.large"
rds_allocated_storage    = 200
rds_multi_az              = true
rds_engine_version        = "15.4"
rds_backup_retention_days = 30
rds_performance_insights  = true

# Lambda - Funciones serverless para procesamiento de pagos (alta concurrencia)
lambda_memory_sizes = {
  originador_pagos   = 1024
  motor_antifraude   = 2048
  buro_riesgos       = 1024
  sistema_liquidacion = 2048
}

lambda_timeout = {
  originador_pagos   = 120
  motor_antifraude   = 180
  buro_riesgos       = 120
  sistema_liquidacion = 300
}

lambda_provisioned_concurrency = {
  originador_pagos   = 10
  motor_antifraude   = 20
  buro_riesgos       = 10
  sistema_liquidacion = 20
}

# ALB - Balanceador de carga de producción con alta disponibilidad
alb_type                = "application"
alb_enable_deletion_protection = true
alb_idle_timeout        = 60
alb_enable_waf          = true
alb_ssl_policy          = "ELBSecurityPolicy-TLS-1-2-2021-07"

# -----------------------------------------------------------------------------
# Configuración de Seguridad - Máxima restricción para producción
# -----------------------------------------------------------------------------

# KMS - Cifrado con rotación obligatoria y claves separadas por servicio
kms_key_administrators = [
  "arn:aws:iam::123456789012:user/prod-admin",
  "arn:aws:iam::123456789012:role/prod-automation",
  "arn:aws:iam::123456789012:root"
]
kms_key_users          = [
  "arn:aws:iam::123456789012:role/prod-app-role",
  "arn:aws:iam::123456789012:role/prod-lambda-role"
]
enable_kms_rotation    = true
kms_key_usage          = "ENCRYPT_DECRYPT"

# IAM - Roles con permisos mínimos y políticas inline específicas
iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/prod-permissions-boundary"
iam_enable_audit       = true
iam_session_duration   = 43200

# Security Groups - Solo IPs específicas para producción
allowed_ssh_cidrs       = ["10.2.0.0/16"]
allowed_https_cidrs     = ["10.0.0.0/8"]
allowed_mgmt_cidrs      = ["10.2.0.0/16"]

# WAF - Web Application Firewall habilitado
waf_enabled            = true
waf_rules = [
  "AWSManagedRulesCommonRuleSet",
  "AWSManagedRulesSQLiRuleSet",
  "AWSManagedRulesKnownBadInputsRuleSet"
]

# -----------------------------------------------------------------------------
# Etiquetas obligatorias para optimización de costos y gobierno
# -----------------------------------------------------------------------------
tags = {
  Environment       = "prod"
  CostCenter        = "pagos-prod"
  Owner             = "equipo-pagos"
  Project           = "red-pagos-segura"
  Compliance        = "PCI-DSS"
  Monitoring        = "enabled"
  Backup            = "hourly"
  DataClassification = "restricted"
  SLA               = "99.9"
  ThroughputTarget  = "10000-TPS"
}

# -----------------------------------------------------------------------------
# Configuración de Observabilidad - Completa para producción
# -----------------------------------------------------------------------------
alarm_email              = "prod-operations@empresa.com"
log_retention_days      = 90
enable_vpc_flow_logs    = true
enable_cloudwatch_logs  = true
enable_detailed_monitoring = true
enable_metrics          = true

# Alarmas específicas para el sistema de pagos
alarm_thresholds = {
  cpu_utilization    = 75
  memory_utilization = 80
  disk_utilization   = 85
  network_throughput = 1000000000
  rds_cpu            = 70
  rds_connections    = 80
  lambda_errors      = 1
  lambda_throttles   = 5
  alb_target_response_time = 1000
  alb_5xx_errors      = 10
}

# -----------------------------------------------------------------------------
# Configuración de Alta Disponibilidad y Recuperación ante Desastres
# -----------------------------------------------------------------------------
enable_deletion_protection = true
backup_retention_days   = 30
rto_minutes             = 15
rpo_minutes             = 5

# Multi-Region para recuperación ante desastres
enable_cross_region_backup = true
backup_replication_region = "us-west-2"
replication_retention_days = 90

# DNS y Routing
enable_route53_health_checks = true
health_check_interval     = 30
failover_threshold        = 3