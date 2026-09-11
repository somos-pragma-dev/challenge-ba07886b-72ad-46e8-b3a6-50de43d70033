resource "aws_db_subnet_group" "pagos_subnet_group" {
  name       = "pagos-db-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-db-subnet-group"
      Description = "Subnets para la base de datos RDS del sistema de pagos"
    }
  )
}
resource "aws_kms_key" "rds_encryption_key" {
  description             = "KMS key para cifrado en reposo de RDS de pagos"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-rds-kms-key"
      Environment = var.environment
    }
  )
}
resource "aws_kms_alias" "rds_encryption_alias" {
  name          = "alias/pagos-rds-kms"
  target_key_id = aws_kms_key.rds_encryption_key.key_id
}
resource "aws_db_instance" "pagos_db" {
  identifier             = "pagos-transactions-db"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  max_allocated_storage  = var.db_max_allocated_storage
  storage_type           = "gp3"
  storage_encrypted      = true
  kms_key_id             = aws_kms_key.rds_encryption_key.arn
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = 5432
  db_subnet_group_name   = aws_db_subnet_group.pagos_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_pagos.id]
  multi_az               = var.environment == "prod" ? true : false
  backup_retention_period = var.db_backup_retention
  backup_window          = "03:00-04:00"
  maintenance_window     = "mon:04:00-mon:05:00"
  skip_final_snapshot    = var.environment != "prod"
  final_snapshot_identifier = var.environment == "prod" ? "pagos-db-final-snapshot-${var.environment}" : null
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  performance_insights_enabled = true
  performance_insights_kms_key_id = aws_kms_key.rds_encryption_key.arn
  deletion_protection      = var.environment == "prod" ? true : false
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-transactions-db"
      Description = "Base de datos RDS para almacenamiento de transacciones de pago"
      Tier        = "MissionCritical"
    }
  )
}
resource "aws_security_group" "rds_pagos" {
  name        = "sg-rds-pagos"
  description = "Security group para RDS del sistema de pagos"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Acceso desde aplicaciones de pagos"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }
  ingress {
    description     = "Acceso desde servicios de monitoreo"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.monitoring_security_group_id]
  }
  egress {
    description = "Salida a internet para actualizaciones"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0/0"]
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "sg-rds-pagos"
      Description = "SG para RDS - acceso limitado a servicios autorizados"
    }
  )
}
resource "aws_db_instance" "auditoria_db" {
  identifier             = "pagos-auditoria-db"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = var.db_instance_class_auditoria
  allocated_storage      = var.db_allocated_storage_auditoria
  max_allocated_storage  = var.db_max_allocated_storage_auditoria
  storage_type           = "gp3"
  storage_encrypted      = true
  kms_key_id             = aws_kms_key.rds_encryption_key.arn
  db_name                = var.db_name_auditoria
  username               = var.db_username
  password               = var.db_password
  port                   = 5432
  db_subnet_group_name   = aws_db_subnet_group.pagos_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_auditoria.id]
  multi_az               = var.environment == "prod" ? true : false
  backup_retention_period = 30
  backup_window          = "02:00-03:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  skip_final_snapshot    = var.environment != "prod"
  final_snapshot_identifier = var.environment == "prod" ? "pagos-auditoria-final-snapshot-${var.environment}" : null
  enabled_cloudwatch_logs_exports = ["postgresql"]
  performance_insights_enabled = true
  performance_insights_kms_key_id = aws_kms_key.rds_encryption_key.arn
  deletion_protection      = true
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-auditoria-db"
      Description = "Base de datos RDS para logs de auditoría del sistema de pagos"
      Compliance  = "PCI-DSS"
    }
  )
}
resource "aws_security_group" "rds_auditoria" {
  name        = "sg-rds-auditoria"
  description = "Security group para RDS de auditoría"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Acceso desde ALB de auditoría"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }
  egress {
    description = "Salida a internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0/0"]
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "sg-rds-auditoria"
      Description = "SG para RDS auditoría - PCI-DSS compliant"
    }
  )
}
resource "aws_s3_bucket" "rds_backup_bucket" {
  bucket = "pagos-rds-backups-${var.environment}"
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-rds-backups"
      Description = "Bucket para backups automatizados de RDS"
    }
  )
}
resource "aws_s3_bucket_server_side_encryption_configuration" "rds_backup_bucket_encryption" {
  bucket = aws_s3_bucket.rds_backup_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_key_arn = aws_kms_key.rds_encryption_key.arn
      sse_algorithm = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_versioning" "rds_backup_bucket_versioning" {
  bucket = aws_s3_bucket.rds_backup_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "rds_backup_bucket_pab" {
  bucket = aws_s3_bucket.rds_backup_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}