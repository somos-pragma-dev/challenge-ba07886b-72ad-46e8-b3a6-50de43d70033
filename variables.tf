# Declaración de variables globales del proyecto de infraestructura
# Estas variables definen la configuración base que se aplica a todos los módulos
# Los valores se proporcionan a través de archivos terraform.tfvars por ambiente

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El ambiente debe ser uno de: dev, qa, prod"
  }
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block principal para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Debe ser un CIDR válido (ej. 10.0.0.0/16)"
  }
}

variable "availability_zones" {
  description = "Lista de AZs a utilizar en el entorno"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs para subredes privadas (aplicación)"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "CIDRs para subredes de base de datos"
  type        = list(string)
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para salida a internet desde subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar una única NAT Gateway para todas las subredes privadas (optimización de costos)"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "Habilitar VPN Gateway para conectividad híbrida"
  type        = bool
  default     = false
}

variable "enable_dx_gateway" {
  description = "Habilitar Direct Connect Gateway para conectividad dedicada"
  type        = bool
  default     = false
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para VPC Flow Logs (cloud-watch-logs, s3, kinesis-data-firehose)"
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_retention_days" {
  description = "Días de retención para logs de flujo de VPC"
  type        = number
  default     = 90
}

variable "enable_transit_gateway" {
  description = "Habilitar Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso a recursos públicos"
  type        = list(string)
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Habilitar DNS hostnames en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "backend_bucket" {
  description = "Nombre del bucket S3 para almacenar el estado de Terraform"
  type        = string
}

variable "backend_dynamodb_table" {
  description = "Nombre de la tabla DynamoDB para lock del estado"
  type        = string
}

variable "nat_gateway_elastic_ips" {
  description = "Cantidad de Elastic IPs para NAT Gateways"
  type        = number
  default     = 0
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

variable "enable_config" {
  description = "Habilitar AWS Config para auditoría de recursos"
  type        = bool
  default     = false
}

variable "enable_cloudtrail" {
  description = "Habilitar CloudTrail para auditoría de eventos"
  type        = bool
  default     = true
}

variable "cloudtrail_bucket_name" {
  description = "Nombre del bucket S3 para logs de CloudTrail"
  type        = string
  default     = ""
}

variable "kms_administrator_arns" {
  description = "ARNs de usuarios que pueden administrar claves KMS"
  type        = list(string)
  default     = []
}

variable "kms_user_arns" {
  description = "ARNs de usuarios que pueden usar claves KMS"
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para los servidores de aplicación"
  type        = string
  default     = "t3.medium"
}

variable "instance_tenancy" {
  description = "Tenancy de las instancias: default o dedicated"
  type        = string
  default     = "default"
}

variable "ssh_key_name" {
  description = "Nombre del par de claves SSH para acceso a instancias"
  type        = string
  default     = ""
}

variable "asg_min_size" {
  description = "Número mínimo de instancias en el Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Número máximo de instancias en el Auto Scaling Group"
  type        = number
  default     = 10
}

variable "asg_desired_capacity" {
  description = "Número deseado de instancias en el Auto Scaling Group"
  type        = number
  default     = 3
}

variable "elb_access_logs_bucket" {
  description = "Bucket S3 para logs de acceso del ALB"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ARN del certificado ACM para HTTPS"
  type        = string
  default     = ""
}

variable "ebs_volume_size" {
  description = "Tamaño del volumen EBS en GB"
  type        = number
  default     = 100
}

variable "admin_cidr_blocks" {
  description = "Bloques CIDR para acceso administrativo"
  type        = list(string)
  default     = []
}