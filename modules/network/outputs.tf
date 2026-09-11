# Outputs del módulo de red: exposición de IDs y ARNs para consumo por otros módulos

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_arn" {
  description = "ARN de la VPC principal"
  value       = aws_vpc.main.arn
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "igw_id" {
  description = "ID del Internet Gateway (alias)"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways por zona de disponibilidad"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_elastic_ips" {
  description = "Elastic IPs asignadas a los NAT Gateways"
  value       = aws_eip.nat_gateway_eip[*].public_ip
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnet_app_ids" {
  description = "IDs de las subredes privadas de aplicación"
  value       = aws_subnet.private[*].id
}

output "private_subnet_data_ids" {
  description = "IDs de las subredes privadas de datos"
  value       = aws_subnet.database[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "IDs de las subredes de base de datos"
  value       = aws_subnet.database[*].id
}

output "database_subnet_group_id" {
  description = "ID del grupo de subredes de base de datos"
  value       = aws_subnet_group.database.id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas por AZ"
  value       = aws_route_table.private[*].id
}

output "public_subnet_cidrs" {
  description = "Bloques CIDR de las subredes públicas"
  value       = var.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "Bloques CIDR de las subredes privadas"
  value       = var.private_subnet_cidrs
}

output "database_subnet_cidrs" {
  description = "Bloques CIDR de las subredes de base de datos"
  value       = var.database_subnet_cidrs
}

output "availability_zones" {
  description = "Zonas de disponibilidad configuradas"
  value       = var.availability_zones
}