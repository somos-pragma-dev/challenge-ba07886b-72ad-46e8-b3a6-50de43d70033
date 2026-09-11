variable "aws_region" {
  description = "Región primaria de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "secondary_region" {
  description = "Región secundaria de AWS para redundancia geográfica"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, qa, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El entorno debe ser uno de: dev, qa, prod"
  }
}

variable "cost_center" {
  description = "Centro de costos para etiquetado y optimización de gastos"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para nomenclatura de recursos"
  type        = string
}

variable "account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR principal para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El CIDR de la VPC debe ser una dirección de red válida"
  }
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para la región primaria"
  type        = list(string)
}

variable "secondary_availability_zones" {
  description = "Zonas de disponibilidad para la región secundaria"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs_pagos" {
  description = "Bloques CIDR para subredes privadas del dominio de pagos"
  type        = list(string)
}

variable "private_subnet_cidrs_monitoreo" {
  description = "Bloques CIDR para subredes privadas de monitoreo"
  type        = list(string)
}

variable "private_subnet_cidrs_auditoria" {
  description = "Bloques CIDR para subredes privadas de auditoría"
  type        = list(string)
}

variable "subnet_public_payments_cidr" {
  description = "CIDR para subred pública de pagos en AZ1"
  type        = string
}

variable "subnet_public_payments_cidr_az2" {
  description = "CIDR para subred pública de pagos en AZ2"
  type        = string
}

variable "subnet_public_monitoring_cidr" {
  description = "CIDR para subred pública de monitoreo en AZ1"
  type        = string
}

variable "subnet_public_monitoring_cidr_az2" {
  description = "CIDR para subred pública de monitoreo en AZ2"
  type        = string
}

variable "subnet_private_payments_cidr" {
  description = "CIDR para subred privada de pagos en AZ1"
  type        = string
}

variable "subnet_private_payments_cidr_az2" {
  description = "CIDR para subred privada de pagos en AZ2"
  type        = string
}

variable "subnet_private_database_cidr" {
  description = "CIDR para subred privada de base de datos en AZ1"
  type        = string
}

variable "subnet_private_database_cidr_az2" {
  description = "CIDR para subred privada de base de datos en AZ2"
  type        = string
}

variable "subnet_private_audit_cidr" {
  description = "CIDR para subred privada de auditoría en AZ1"
  type        = string
}

variable "subnet_private_audit_cidr_az2" {
  description = "CIDR para subred privada de auditoría en AZ2"
  type        = string
}

variable "nat_gateway_count" {
  description = "Cantidad de NAT Gateways a desplegar (1 por AZ o 1 único)"
  type        = number
  validation {
    condition     = var.nat_gateway_count >= 1 && var.nat_gateway_count <= 3
    error_message = "La cantidad de NAT Gateways debe estar entre 1 y 3"
  }
}

variable "enable_vpn_gateway" {
  description = "Habilitar VPN Gateway para acceso seguro a la VPC"
  type        = bool
  default     = false
}

variable "enable_transit_gateway" {
  description = "Habilitar Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR autorizados para acceso a servicios públicos"
  type        = list(string)
}

variable "enable_flow_logs" {
  description = "Habilitar VPC Flow Logs para observabilidad del tráfico"
  type        = bool
  default     = true
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para VPC Flow Logs (s3, cloud-watch-logs)"
  type        = string
  default     = "s3"
  validation {
    condition     = contains(["s3", "cloud-watch-logs"], var.flow_log_destination_type)
    error_message = "El tipo de destino debe ser s3 o cloud-watch-logs"
  }
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas adicionales para todos los recursos"
  type        = map(string)
  default     = {}
}

variable "s3_bucket_prefix" {
  description = "Prefijo para nombres de buckets S3"
  type        = string
}

variable "rds_instance_class" {
  description = "Clase de instancia RDS para la base de datos de pagos"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Almacenamiento allocated para RDS en GB"
  type        = number
}

variable "rds_multi_az" {
  description = "Habilitar despliegue Multi-AZ para RDS"
  type        = bool
  default     = true
}

variable "lambda_runtime" {
  description = "Runtime para funciones Lambda"
  type        = string
  default     = "python3.11"
}

variable "lambda_memory_size" {
  description = "Memoria en MB para funciones Lambda"
  type        = number
  default     = 256
}

variable "lambda_timeout" {
  description = "Timeout en segundos para funciones Lambda"
  type        = number
  default     = 30
}

variable "alb_timeout" {
  description = "Timeout de respuesta del ALB en segundos"
  type        = number
  default     = 60
}

variable "alb_deletion_protection" {
  description = "Habilitar protección contra eliminación del ALB"
  type        = bool
  default     = true
}

variable "kms_key_administrators" {
  description = "ARNs de usuarios que pueden administrar claves KMS"
  type        = list(string)
}

variable "kms_key_users" {
  description = "ARNs de usuarios que pueden usar claves KMS"
  type        = list(string)
}

variable "eks_cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  type        = string
  default     = ""
}

variable "eks_cluster_ca_cert" {
  description = "Certificado CA del cluster EKS (base64)"
  type        = string
  default     = ""
}

variable "eks_cluster_token" {
  description = "Token de acceso al cluster EKS"
  type        = string
  default     = ""
  sensitive   = true
}

variable "enable_waf" {
  description = "Habilitar AWS WAF para protección de aplicaciones"
  type        = bool
  default     = false
}

variable "cloudwatch_log_retention_days" {
  description = "Días de retención para logs de CloudWatch"
  type        = number
  default     = 90
  validation {
    condition     = var.cloudwatch_log_retention_days >= 1 && var.cloudwatch_log_retention_days <= 365
    error_message = "Los días de retención deben estar entre 1 y 365"
  }
}

variable "enable_guardduty" {
  description = "Habilitar Amazon GuardDuty para detección de amenazas"
  type        = bool
  default     = false
}

variable "rto_minutes" {
  description = "Recovery Time Objective en minutos"
  type        = number
  default     = 60
}

variable "rpo_minutes" {
  description = "Recovery Point Objective en minutos"
  type        = number
  default     = 15
}