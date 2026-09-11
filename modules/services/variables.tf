variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "cost_center" {
  description = "Centro de costos"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Lista de IDs de subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs de subredes privadas"
  type        = list(string)
}

variable "lambda_security_group_id" {
  description = "ID del security group para Lambda"
  type        = string
}

variable "app_security_group_id" {
  description = "ID del security group de aplicaciones"
  type        = string
}

variable "monitoring_security_group_id" {
  description = "ID del security group de monitoreo"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID del security group del ALB"
  type        = string
}

variable "fraud_detection_table" {
  description = "Nombre de la tabla de detección de fraude"
  type        = string
}

variable "settlement_table" {
  description = "Nombre de la tabla de liquidación"
  type        = string
}

variable "transaction_table" {
  description = "Nombre de la tabla de transacciones"
  type        = string
}

variable "rds_endpoint" {
  description = "Endpoint de la instancia RDS"
  type        = string
}

variable "db_instance_class" {
  description = "Clase de instancia de RDS"
  type        = string
}

variable "db_allocated_storage" {
  description = "Almacenamiento allocated para RDS en GB"
  type        = number
}

variable "db_max_allocated_storage" {
  description = "Almacenamiento máximo para RDS"
  type        = number
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_backup_retention" {
  description = "Días de retención de backups"
  type        = number
  default     = 7
}

variable "db_instance_class_auditoria" {
  description = "Clase de instancia de RDS para auditoría"
  type        = string
}

variable "db_allocated_storage_auditoria" {
  description = "Almacenamiento allocated para RDS de auditoría"
  type        = number
}

variable "db_max_allocated_storage_auditoria" {
  description = "Almacenamiento máximo para RDS de auditoría"
  type        = number
}

variable "db_name_auditoria" {
  description = "Nombre de la base de datos de auditoría"
  type        = string
}

variable "alb_domain_name" {
  description = "Nombre de dominio para el ALB"
  type        = string
}

variable "alb_subject_alternative_names" {
  description = "Nombres alternativos para el certificado del ALB"
  type        = list(string)
  default     = []
}

variable "sns_topic_arn" {
  description = "ARN del topic SNS para alarmas"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}