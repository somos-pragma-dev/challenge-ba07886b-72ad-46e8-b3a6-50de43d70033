# Variables específicas del módulo de seguridad
# Este módulo encapsula la configuración de IAM roles, políticas, security group
# y otros recursos de seguridad necesarios para el entorno de pagos

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se aplicarán los security groups"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
  default     = ""
}

variable "public_subnet_ids" {
  description = "IDs de subredes públicas"
  type        = list(string)
  default     = []
}

variable "private_subnet_ids" {
  description = "IDs de subredes privadas"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR autorizados para acceso a recursos"
  type        = list(string)
  default     = []
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos de seguridad"
  type        = map(string)
}

variable "enable_iam_roles" {
  description = "Habilitar la creación de roles IAM para los componentes"
  type        = bool
  default     = true
}

variable "enable_security_groups" {
  description = "Habilitar la creación de security groups"
  type        = bool
  default     = true
}

variable "create_payment_gateway_role" {
  description = "Crear rol IAM específico para el gateway de pagos"
  type        = bool
  default     = true
}

variable "create_settlement_role" {
  description = "Crear rol IAM específico para el sistema de liquidación"
  type        = bool
  default     = true
}

variable "create_fraud_engine_role" {
  description = "Crear rol IAM específico para el motor antifraude"
  type        = bool
  default     = true
}

variable "payment_gateway_policy" {
  description = "Política personalizada para el gateway de pagos (JSON)"
  type        = string
  default     = ""
}

variable "settlement_policy" {
  description = "Política personalizada para el sistema de liquidación (JSON)"
  type        = string
  default     = ""
}

variable "fraud_engine_policy" {
  description = "Política personalizada para el motor antifraude (JSON)"
  type        = string
  default     = ""
}

variable "security_group_rules" {
  description = "Definición de reglas de security groups personalizada"
  type = object({
    http_port      = number
    https_port     = number
    mysql_port     = number
    postgres_port  = number
    redis_port     = number
    rabbitmq_port  = number
    internal_port  = number
    monitoring_port = number
  })
  default = {
    http_port       = 80
    https_port      = 443
    mysql_port      = 3306
    postgres_port   = 5432
    redis_port      = 6379
    rabbitmq_port   = 5672
    internal_port   = 8080
    monitoring_port = 9090
  }
}

variable "allowed_ingress_ports" {
  description = "Puertos que permiten tráfico entrante desde fuentes externas"
  type        = list(number)
  default     = [443, 22]
}

variable "enable_cloudtrail" {
  description = "Habilitar CloudTrail para auditoría de eventos"
  type        = bool
  default     = true
}

variable "enable_guardduty" {
  description = "Habilitar GuardDuty para detección de amenazas"
  type        = bool
  default     = false
}

variable "enable_security_hub" {
  description = "Habilitar Security Hub para consolidación de hallazgos"
  type        = bool
  default     = false
}

variable "kms_key_administrators" {
  description = "ARNs de usuarios que pueden administrar la clave KMS"
  type        = list(string)
  default     = []
}

variable "kms_key_users" {
  description = "ARNs de usuarios que pueden usar la clave KMS para cifrado/descifrado"
  type        = list(string)
  default     = []
}

variable "enable_secrets_manager" {
  description = "Habilitar Secrets Manager para gestión de credenciales"
  type        = bool
  default     = true
}

variable "secrets_manager_secret_names" {
  description = "Nombres de los secrets a crear en Secrets Manager"
  type        = list(string)
  default     = []
}

variable "enable_waf" {
  description = "Habilitar WAF para protección de aplicaciones web"
  type        = bool
  default     = false
}

variable "waf_web_acl_rules" {
  description = "Configuración de reglas de WAF Web ACL"
  type        = any
  default     = {}
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación en recursos críticos"
  type        = bool
  default     = true
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "ID de cuenta de AWS"
  type        = string
  default     = ""
}

variable "logs_bucket_name" {
  description = "Nombre del bucket S3 para logs"
  type        = string
  default     = ""
}

variable "bastion_ssh_cidr" {
  description = "Bloque CIDR para acceso SSH al bastion"
  type        = string
  default     = "10.0.0.0/16"
}