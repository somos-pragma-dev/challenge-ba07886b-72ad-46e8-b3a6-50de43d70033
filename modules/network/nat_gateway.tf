resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-nat-eip"
      Description = "Elastic IP para NAT Gateway"
      Component   = "Network"
      Layer       = "Public"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-nat-gw"
      Description = "NAT Gateway para acceso a internet desde subredes privadas"
      Component   = "Network"
      Layer       = "Private"
      Purpose     = "Egress-to-Internet"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ec2_tag" "nat_cost_tag" {
  resource_id = aws_nat_gateway.main.id
  key         = "CostCenter"
  value       = var.cost_center
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "nat_gateway_arn" {
  description = "ARN del NAT Gateway"
  value       = aws_nat_gateway.main.arn
}

output "nat_eip_allocation_id" {
  description = "Allocation ID de la EIP asociada al NAT Gateway"
  value       = aws_eip.nat.id
}