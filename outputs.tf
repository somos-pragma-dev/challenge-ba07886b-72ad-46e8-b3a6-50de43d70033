# =============================================================================
# OUTPUTS DE VPC - Identificadores y configuración de la red virtual
# =============================================================================
output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC principal"
  value       = aws_vpc.main.cidr_block
}

output "vpc_dns_hostnames_enabled" {
  description = "Indicador de DNS hostnames habilitado"
  value       = aws_vpc.main.enable_dns_hostnames
}

output "vpc_dns_support_enabled" {
  description = "Indicador de DNS support habilitado"
  value       = aws_vpc.main.enable_dns_support
}

# =============================================================================
# OUTPUTS DE SUBREDES PÚBLICAS
# =============================================================================
output "subnet_public_payments_id" {
  description = "ID de subred pública de pagos AZ1"
  value       = aws_subnet.public_payments.id
}

output "subnet_public_payments_az2_id" {
  description = "ID de subred pública de pagos AZ2"
  value       = aws_subnet.public_payments_az2.id
}

output "subnet_public_monitoring_id" {
  description = "ID de subred pública de monitoreo AZ1"
  value       = aws_subnet.public_monitoring.id
}

output "subnet_public_monitoring_az2_id" {
  description = "ID de subred pública de monitoreo AZ2"
  value       = aws_subnet.public_monitoring_az2.id
}

output "public_subnet_ids" {
  description = "Lista de IDs de todas las subredes públicas"
  value       = [aws_subnet.public_payments.id, aws_subnet.public_payments_az2.id, aws_subnet.public_monitoring.id, aws_subnet.public_monitoring_az2.id]
}

output "public_subnets_cidrs" {
  description = "Lista de bloques CIDR de todas las subredes públicas"
  value       = [var.subnet_public_payments_cidr, var.subnet_public_payments_cidr_az2, var.subnet_public_monitoring_cidr, var.subnet_public_monitoring_cidr_az2]
}

# =============================================================================
# OUTPUTS DE SUBREDES PRIVADAS
# =============================================================================
output "subnet_private_payments_id" {
  description = "ID de subred privada de pagos AZ1"
  value       = aws_subnet.private_payments.id
}

output "subnet_private_payments_az2_id" {
  description = "ID de subred privada de pagos AZ2"
  value       = aws_subnet.private_payments_az2.id
}

output "subnet_private_database_id" {
  description = "ID de subred privada de base de datos AZ1"
  value       = aws_subnet.private_database.id
}

output "subnet_private_database_az2_id" {
  description = "ID de subred privada de base de datos AZ2"
  value       = aws_subnet.private_database_az2.id
}

output "subnet_private_audit_id" {
  description = "ID de subred privada de auditoría AZ1"
  value       = aws_subnet.private_audit.id
}

output "subnet_private_audit_az2_id" {
  description = "ID de subred privada de auditoría AZ2"
  value       = aws_subnet.private_audit_az2.id
}

output "private_subnet_ids" {
  description = "Lista de IDs de todas las subredes privadas"
  value       = [aws_subnet.private_payments.id, aws_subnet.private_payments_az2.id, aws_subnet.private_database.id, aws_subnet.private_database_az2.id, aws_subnet.private_audit.id, aws_subnet.private_audit_az2.id]
}

output "private_subnets_cidrs" {
  description = "Lista de bloques CIDR de todas las subredes privadas"
  value       = [var.subnet_private_payments_cidr, var.subnet_private_payments_cidr_az2, var.subnet_private_database_cidr, var.subnet_private_database_cidr_az2, var.subnet_private_audit_cidr, var.subnet_private_audit_cidr_az2]
}

# =============================================================================
# OUTPUTS DE GATEWAYS
# =============================================================================
output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_az1_id" {
  description = "ID del NAT Gateway AZ1"
  value       = aws_nat_gateway.main_az1.id
}

output "nat_gateway_az2_id" {
  description = "ID del NAT Gateway AZ2"
  value       = aws_nat_gateway.main_az2.id
}

output "nat_gateway_az1_ip" {
  description = "IP elástica del NAT Gateway AZ1"
  value       = aws_eip.nat_eip_az1.public_ip
}

output "nat_gateway_az2_ip" {
  description = "IP elástica del NAT Gateway AZ2"
  value       = aws_eip.nat_eip_az2.public_ip
}

output "nat_gateway_ids" {
  description = "Lista de IDs de todos los NAT Gateways"
  value       = [aws_nat_gateway.main_az1.id, aws_nat_gateway.main_az2.id]
}

# =============================================================================
# OUTPUTS DE TABLAS DE RUTAS
# =============================================================================
output "route_table_public_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "route_table_private_az1_id" {
  description = "ID de la tabla de rutas privada AZ1"
  value       = aws_route_table.private_az1.id
}

output "route_table_private_az2_id" {
  description = "ID de la tabla de rutas privada AZ2"
  value       = aws_route_table.private_az2.id
}

output "all_route_table_ids" {
  description = "Lista de IDs de todas las tablas de rutas"
  value       = [aws_route_table.public.id, aws_route_table.private_az1.id, aws_route_table.private_az2.id]
}

# =============================================================================
# OUTPUTS DE ARQUITECTURA - Para integración con otros módulos
# =============================================================================
output "availability_zones" {
  description = "Lista de AZs disponibles utilizadas"
  value       = data.aws_availability_zones.available.names
}

output "network_architecture" {
  description = "Descripción de la arquitectura de red"
  value = {
    vpc_cidr               = aws_vpc.main.cidr_block
    public_subnets         = "4 subredes públicas en 2 AZs (pagos y monitoreo)"
    private_subnets        = "6 subredes privadas en 2 AZs (pagos, database, audit)"
    internet_gateway       = "1 IGW para acceso público"
    nat_gateways           = "2 NAT Gateways (uno por AZ) para salida privada"
    high_availability      = "Despliegue multi-AZ para tolerancia a fallos"
    isolation_level        = "Segmentación completa entre tiers públicos y privados"
    payment_services_subnets = [aws_subnet.private_payments.id, aws_subnet.private_payments_az2.id]
    database_subnets       = [aws_subnet.private_database.id, aws_subnet.private_database_az2.id]
    audit_subnets          = [aws_subnet.private_audit.id, aws_subnet.private_audit_az2.id]
  }
}