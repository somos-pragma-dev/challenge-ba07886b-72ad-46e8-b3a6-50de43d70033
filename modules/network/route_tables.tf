resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-public-rt-${var.environment}"
      Description = "Tabla de rutas para subredes públicas - acceso a internet via IGW"
      Type        = "public"
      Layer       = "network"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  route {
    cidr_block                = "10.0.0.0/8"
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-private-rt-${var.environment}"
      Description = "Tabla de rutas para subredes privadas - acceso a internet via NAT Gateway"
      Type        = "private"
      Layer       = "network"
    }
  )
}

resource "aws_route_table" "pagos" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  route {
    cidr_block                = "10.0.0.0/8"
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-pagos-rt-${var.environment}"
      Description = "Tabla de rutas dedicada para subredes de pagos"
      Purpose     = "pagos"
      Type        = "private"
      Layer       = "network"
    }
  )
}

resource "aws_route_table_association" "public" {
  for_each = toset(var.public_subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = toset([for s in var.private_subnet_ids : s if s != var.pagos_db_subnet_ids[0] && s != var.pagos_db_subnet_ids[1]])

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "pagos" {
  for_each = toset([for s in var.private_subnet_ids : s if s == var.pagos_db_subnet_ids[0] || s == var.pagos_db_subnet_ids[1]])

  subnet_id      = each.value
  route_table_id = aws_route_table.pagos.id
}

resource "aws_route" "vpn_to_onpremises" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = var.onpremises_cidr
  gateway_id = var.vpn_gateway_id
}

resource "aws_route" "s3_via_endpoint" {
  route_table_id = aws_route_table.private.id
  destination_prefix_list_id = "pl-63a5400a"
  vpc_endpoint_id = var.s3_endpoint_id
}

resource "aws_route" "dynamodb_via_endpoint" {
  route_table_id = aws_route_table.private.id
  destination_prefix_list_id = "pl-63a6400b"
  vpc_endpoint_id = var.dynamodb_endpoint_id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID de la tabla de rutas privada"
  value       = aws_route_table.private.id
}

output "pagos_route_table_id" {
  description = "ID de la tabla de rutas de pagos"
  value       = aws_route_table.pagos.id
}