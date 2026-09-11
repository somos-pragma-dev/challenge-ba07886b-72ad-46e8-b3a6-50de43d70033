resource "aws_kms_key" "payments_master_key" {
  description = "Master KMS key for payments encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  tags = merge(var.common_tags, {
    Name = "payments-master-key-${var.environment}"
    Purpose = "encryption-master"
  })
}

resource "aws_kms_alias" "payments_master_key_alias" {
  name = "alias/payments-master-key-${var.environment}"
  target_key_id = aws_kms_key.payments_master_key.key_id
}

resource "aws_kms_key" "rds_encryption_key" {
  description = "KMS key for RDS database encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "rds-key-policy-${var.environment}"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow RDS to use the key"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
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
            "kms:ViaService" = "rds.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "rds-encryption-key-${var.environment}"
    Purpose = "rds-encryption"
  })
}

resource "aws_kms_alias" "rds_encryption_key_alias" {
  name = "alias/rds-encryption-key-${var.environment}"
  target_key_id = aws_kms_key.rds_encryption_key.key_id
}

resource "aws_kms_key" "s3_encryption_key" {
  description = "KMS key for S3 bucket encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "s3-key-policy-${var.environment}"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow S3 to use the key for encryption"
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
            "kms:ViaService" = "s3.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "s3-encryption-key-${var.environment}"
    Purpose = "s3-encryption"
  })
}

resource "aws_kms_alias" "s3_encryption_key_alias" {
  name = "alias/s3-encryption-key-${var.environment}"
  target_key_id = aws_kms_key.s3_encryption_key.key_id
}

resource "aws_kms_key" "dynamodb_encryption_key" {
  description = "KMS key for DynamoDB table encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "dynamodb-key-policy-${var.environment}"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow DynamoDB to use the key"
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
            "kms:ViaService" = "dynamodb.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "dynamodb-encryption-key-${var.environment}"
    Purpose = "dynamodb-encryption"
  })
}

resource "aws_kms_alias" "dynamodb_encryption_key_alias" {
  name = "alias/dynamodb-encryption-key-${var.environment}"
  target_key_id = aws_kms_key.dynamodb_encryption_key.key_id
}

resource "aws_kms_key" "alb_encryption_key" {
  description = "KMS key for ALB TLS termination in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  tags = merge(var.common_tags, {
    Name = "alb-tls-key-${var.environment}"
    Purpose = "alb-tls-termination"
  })
}

resource "aws_kms_alias" "alb_encryption_key_alias" {
  name = "alias/alb-tls-key-${var.environment}"
  target_key_id = aws_kms_key.alb_encryption_key.key_id
}

resource "aws_kms_key" "logs_encryption_key" {
  description = "KMS key for CloudWatch Logs encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "logs-key-policy-${var.environment}"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow CloudWatch Logs to use the key"
        Effect = "Allow"
        Principal = {
          Service = "logs.${var.aws_region}.amazonaws.com"
        }
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "logs.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "logs-encryption-key-${var.environment}"
    Purpose = "cloudwatch-logs-encryption"
  })
}

resource "aws_kms_alias" "logs_encryption_key_alias" {
  name = "alias/logs-encryption-key-${var.environment}"
  target_key_id = aws_kms_key.logs_encryption_key.key_id
}