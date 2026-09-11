# Configuración de providers y versiones de Terraform
# Este archivo define los providers necesarios para el despliegue de infraestructura en AWS
# y especifica las restricciones de versión para garantizar compatibilidad

terraform {
  required_version = ">= 1.5, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider de AWS con configuración regional y opciones de comportamiento
# La región se define mediante variable de entorno AWS_DEFAULT_REGION o se sobrescribe en tfvars
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.common_tags
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = true

  endpoints {
    ec2        = "ec2.${var.aws_region}.amazonaws.com"
    elb        = "elasticloadbalancing.${var.aws_region}.amazonaws.com"
    iam        = "iam.${var.aws_region}.amazonaws.com"
    cloudwatch = "logs.${var.aws_region}.amazonaws.com"
  }
}