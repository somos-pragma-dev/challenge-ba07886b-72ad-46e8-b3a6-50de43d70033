resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-vpc-${var.environment}"
      Purpose     = "Infraestructura principal de red"
      Layer       = "network"
      ManagedBy   = "terraform"
    }
  )
}

resource "aws_default_security_group" "vpc_default" {
  vpc_id = aws_vpc.main.id

  ingress = []
  egress  = []

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-default-sg-${var.environment}"
      Description = "Security group por defecto - restringir todo tráfico"
    }
  )
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = concat(
    [aws_route_table.public.id],
    [aws_route_table.private.id]
  )

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-s3-endpoint-${var.environment}"
      Purpose    = "Acceso privado a S3 sin tráfico por internet"
    }
  )
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.dynamodb"
  route_table_ids = concat(
    [aws_route_table.public.id],
    [aws_route_table.private.id]
  )

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-dynamodb-endpoint-${var.environment}"
      Purpose    = "Acceso privado a DynamoDB sin tráfico por internet"
    }
  )
}

resource "aws_vpc_endpoint" "secrets_manager_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.secretsmanager"
  route_table_ids = [aws_route_table.private.id]

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-secrets-manager-endpoint-${var.environment}"
      Purpose    = "Acceso privado a Secrets Manager desde subredes privadas"
    }
  )
}

resource "aws_vpc_endpoint" "ssm_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.ssm"
  route_table_ids = [aws_route_table.private.id]

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-ssm-endpoint-${var.environment}"
      Purpose    = "Acceso privado a SSM para gestión de instancias"
    }
  )
}

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "default_security_group_id" {
  description = "ID del security group por defecto de la VPC"
  value       = aws_default_security_group.vpc_default.id
}