# =============================================================================
# CONFIGURACIÓN DEL BACKEND REMOTO
# Almacena el estado de Terraform en S3 con bloqueo en DynamoDB
# =============================================================================
terraform {
  backend "s3" {
    bucket         = "${var.project_name}-terraform-state-${var.environment}"
    key            = "${var.environment}/network/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "${var.project_name}-terraform-locks"

    # Configuración de versioning del bucket de estado
    versioning = true

    # Prevent accidental deletion of state
    skip_bucket_versioning = false
  }
}

# =============================================================================
# RECURSOS DE INFRAESTRUCTURA PARA EL BACKEND
# Estos recursos deben existir antes de usar el backend remoto
# =============================================================================

# Bucket S3 para almacenar el estado de Terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-terraform-state-${var.environment}"

  tags = {
    Name        = "${var.project_name}-terraform-state-${var.environment}"
    Description = "Bucket para almacenar estado de Terraform"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Versioning del bucket de estado
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Bloqueo público al bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Servidor de encriptación del bucket con KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Tabla DynamoDB para bloqueo de estado
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.project_name}-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.project_name}-terraform-locks"
    Description = "Tabla para bloqueo de estado de Terraform"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Política de acceso a la tabla de bloqueo
resource "aws_dynamodb_table_policy" "terraform_locks_policy" {
  name = "${var.project_name}-terraform-locks-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowTerraformLocking"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Resource = aws_dynamodb_table.terraform_locks.arn
        Condition = {
          Bool = {
            "aws:SecureTransport" = "true"
          }
        }
      }
    ]
  })
}

# =============================================================================
# LLAVE KMS PARA CIFRADO DEL ESTADO
# Cifrado en reposo para el bucket S3 y tabla DynamoDB
# =============================================================================
resource "aws_kms_key" "terraform_state" {
  description             = "Llave KMS para cifrado del estado de Terraform"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "terraform-state-key-policy"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow S3 to use this key"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          }
        }
      },
      {
        Sid    = "Allow DynamoDB to use this key"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          }
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-kms-terraform-state"
    Description = "Llave KMS para cifrado del estado de Terraform"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Alias de la llave KMS
resource "aws_kms_alias" "terraform_state" {
  name          = "alias/${var.project_name}-terraform-state"
  target_key_id = aws_kms_key.terraform_state.key_id
}