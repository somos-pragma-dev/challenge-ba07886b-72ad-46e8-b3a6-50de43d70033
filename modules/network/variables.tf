# Variables específicas del módulo de red (VPC, subredes, tablas de rutas, NAT Gateway)
# Este módulo encapsula toda la configuración relacionada con la topología de red
# incluyendo segmentación entre subredes públicas, privadas y de base de datos

variable "vpc_name" {
  description = "Nombre identificador para la VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block principal de la VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para las subredes"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para subredes públicas (con acceso a internet)"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Bloques CIDR para subredes privadas (aplicaciones, sin acceso directo a internet)"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Bloques CIDR para subredes de base de datos (aislamiento máximo)"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Determina si se crean NAT Gateways para permitir salida a internet desde subredes privadas"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Si es true, se crea una única NAT Gateway en lugar de una por AZ (ahorra costos)"
  type        = bool
}

variable "enable_vpn_gateway" {
  description = "Habilita el Virtual Private Gateway para conexiones VPN site-to-site"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Habilita la resolución de DNS hostnames dentro de la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilita el soporte de DNS dentro de la VPC"
  type        = bool
  default     = true
}

variable "enable_transit_gateway" {
  description = "Configura attachment al Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "transit_gateway_id" {
  description = "ID del Transit Gateway al cual conectar esta VPC"
  type        = string
  default     = ""
}

variable "map_public_ip_on_launch" {
  description = "Asignar IP pública automáticamente a instancias en subredes públicas"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Ambiente de despliegue para etiquetado"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "common_tags" {
  description = "Tags comunes heredados del proyecto"
  type        = map(string)
}

variable "nat_gateway_elastic_ips" {
  description = "Cantidad de Elastic IPs para NAT Gateways (debe coincidir con número de AZs si single_nat_gateway es false)"
  type        = number
  default     = 0
}

variable "enable_flow_log" {
  description = "Habilitar VPC Flow Logs para monitoreo de tráfico"
  type        = bool
  default     = true
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para flow logs: cloud-watch-logs, s3, o kinesis-data-firehose"
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_cloudwatch_log_group_name" {
  description = "Nombre del Log Group en CloudWatch para flow logs"
  type        = string
  default     = ""
}

variable "flow_log_cloudwatch_log_group_arn" {
  description = "ARN del Log Group de CloudWatch existente para flow logs"
  type        = string
  default     = ""
}

variable "flow_log_iam_role_arn" {
  description = "ARN del rol IAM para publicación de flow logs"
  type        = string
  default     = ""
}

variable "flow_log_traffic_type" {
  description = "Tipo de tráfico a registrar: ACCEPT, REJECT, o ALL"
  type        = string
  default     = "ALL"
}

variable "flow_log_format" {
  description = "Formato personalizado para VPC Flow Logs"
  type        = string
  default     = "${version} ${account-id} ${interface-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${packets} ${bytes} ${start} ${end} ${action} ${log-status}"
}

variable "enable_classiclink" {
  description = "Habilitar ClassicLink para compatibilidad con EC2-Classic"
  type        = bool
  default     = false
}

variable "enable_ipv6" {
  description = "Habilitar IPv6 en la VPC"
  type        = bool
  default     = false
}