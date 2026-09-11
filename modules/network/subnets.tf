locals {
  availability_zones = var.availability_zones
  
  subnets_public = {
    "public_monitoreo_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 0)
      availability_zone = local.availability_zones[0]
      purpose           = "monitoreo"
      type              = "public"
    }
    "public_monitoreo_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 1)
      availability_zone = local.availability_zones[1]
      purpose           = "monitoreo"
      type              = "public"
    }
    "public_auditoria_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 2)
      availability_zone = local.availability_zones[0]
      purpose           = "auditoria"
      type              = "public"
    }
    "public_auditoria_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 3)
      availability_zone = local.availability_zones[1]
      purpose           = "auditoria"
      type              = "public"
    }
  }
  
  subnets_private = {
    "private_pagos_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 4)
      availability_zone = local.availability_zones[0]
      purpose           = "pagos"
      type              = "private"
    }
    "private_pagos_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 5)
      availability_zone = local.availability_zones[1]
      purpose           = "pagos"
      type              = "private"
    }
    "private_pagos_db_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 6)
      availability_zone = local.availability_zones[0]
      purpose           = "pagos"
      type              = "private"
      database          = true
    }
    "private_pagos_db_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 7)
      availability_zone = local.availability_zones[1]
      purpose           = "pagos"
      type              = "private"
      database          = true
    }
    "private_monitoreo_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 8)
      availability_zone = local.availability_zones[0]
      purpose           = "monitoreo"
      type              = "private"
    }
    "private_monitoreo_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 9)
      availability_zone = local.availability_zones[1]
      purpose           = "monitoreo"
      type              = "private"
    }
    "private_auditoria_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 10)
      availability_zone = local.availability_zones[0]
      purpose           = "auditoria"
      type              = "private"
    }
    "private_auditoria_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 11)
      availability_zone = local.availability_zones[1]
      purpose           = "auditoria"
      type              = "private"
    }
  }
  
  all_subnets = merge(local.subnets_public, local.subnets_private)
}

resource "aws_subnet" "main" {
  for_each = local.all_subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.type == "public"

  tags = merge(
    var.common_tags,
    {
      Name               = "${var.project_name}-${each.key}-${var.environment}"
      Purpose            = each.value.purpose
      Type               = each.value.type
      Layer              = "network"
      AvailabilityZone   = each.value.availability_zone
      CostCenter         = var.cost_center
      Environment        = var.environment
      "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
    }
  )
}

resource "aws_subnet_group" "pagos" {
  name = "${var.project_name}-pagos-subnet-group-${var.environment}"
  
  subnet_ids = [for k, v in aws_subnet.main : aws_subnet.main[k].id if v.tags.Purpose == "pagos"]
  
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-pagos-subnet-group-${var.environment}"
      Description = "Grupo de subredes para servicios de pagos"
    }
  )
}

resource "aws_subnet_group" "monitoreo" {
  name = "${var.project_name}-monitoreo-subnet-group-${var.environment}"
  
  subnet_ids = [for k, v in aws_subnet.main : aws_subnet.main[k].id if v.tags.Purpose == "monitoreo"]
  
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-monitoreo-subnet-group-${var.environment}"
      Description = "Grupo de subredes para servicios de monitoreo"
    }
  )
}

resource "aws_subnet_group" "auditoria" {
  name = "${var.project_name}-auditoria-subnet-group-${var.environment}"
  
  subnet_ids = [for k, v in aws_subnet.main : aws_subnet.main[k].id if v.tags.Purpose == "auditoria"]
  
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-auditoria-subnet-group-${var.environment}"
      Description = "Grupo de subredes para servicios de auditoría"
    }
  )
}

output "subnet_ids" {
  description = "Mapeo de IDs de subredes por nombre"
  value       = { for k, v in aws_subnet.main : k => v.id }
}

output "public_subnet_ids" {
  description = "IDs de subredes públicas"
  value       = [for k, v in aws_subnet.main : v.id if v.tags.Type == "public"]
}

output "private_subnet_ids" {
  description = "IDs de subredes privadas"
  value       = [for k, v in aws_subnet.main : v.id if v.tags.Type == "private"]
}

output "pagos_subnet_ids" {
  description = "IDs de subredes de pagos"
  value       = [for k, v in aws_subnet.main : v.id if v.tags.Purpose == "pagos"]
}