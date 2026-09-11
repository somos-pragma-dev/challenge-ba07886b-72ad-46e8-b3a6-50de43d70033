variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "region" {
  description = "Región de AWS"
  type        = string
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}

variable "cost_center" {
  description = "Centro de costos para etiquetado"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes para todos los recursos"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID de la VPC existente"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID del Internet Gateway"
  type        = string
}

variable "nat_gateway_id" {
  description = "ID del NAT Gateway"
  type        = string
}

variable "vpc_peering_connection_id" {
  description = "ID de la conexión de VPC Peering"
  type        = string
  default     = ""
}

variable "onpremises_cidr" {
  description = "Bloque CIDR de la red on-premises"
  type        = string
  default     = ""
}

variable "vpn_gateway_id" {
  description = "ID del VPN Gateway"
  type        = string
  default     = ""
}

variable "s3_endpoint_id" {
  description = "ID del endpoint de S3"
  type        = string
  default     = ""
}

variable "dynamodb_endpoint_id" {
  description = "ID del endpoint de DynamoDB"
  type        = string
  default     = ""
}

variable "public_subnet_ids" {
  description = "Lista de IDs de subredes públicas"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas"
  type        = list(string)
}

variable "pagos_db_subnet_ids" {
  description = "Lista de IDs de subredes de base de datos de pagos"
  type        = list(string)
}

variable "public_subnet_id" {
  description = "ID de la subred pública donde se desplegará el NAT Gateway"
  type        = string
}