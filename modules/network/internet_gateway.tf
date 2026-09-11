resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-igw"
      Description = "Internet Gateway para subredes públicas del entorno de pagos"
      Component   = "Network"
      Layer       = "Public"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ec2_tag" "igw_cost_tag" {
  resource_id = aws_internet_gateway.main.id
  key         = "CostCenter"
  value       = var.cost_center
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "internet_gateway_arn" {
  description = "ARN del Internet Gateway"
  value       = aws_internet_gateway.main.arn
}