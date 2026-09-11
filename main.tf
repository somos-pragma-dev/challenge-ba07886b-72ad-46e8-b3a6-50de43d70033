locals {
  common_tags = {
    Environment = var.environment
    Project     = "pagos-seguro"
    ManagedBy   = "terraform"
    Owner       = "cloudops-team"
    CostCenter  = "finanzas"
    Compliance  = "pci-dss"
  }

  vpc_cidr = var.vpc_cidr

  availability_zones = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]

  public_subnet_cidrs = [for i in range(length(local.availability_zones)) : cidrsubnet(local.vpc_cidr, 4, i)]

  private_subnet_app_cidrs = [for i in range(length(local.availability_zones)) : cidrsubnet(local.vpc_cidr, 4, length(local.availability_zones) + i)]

  private_subnet_data_cidrs = [for i in range(length(local.availability_zones)) : cidrsubnet(local.vpc_cidr, 4, 2 * length(local.availability_zones) + i)]

  private_subnet_mgmt_cidrs = [for i in range(length(local.availability_zones)) : cidrsubnet(local.vpc_cidr, 4, 3 * length(local.availability_zones) + i)]
}

module "network" {
  source = "./modules/network"

  environment           = var.environment
  vpc_cidr              = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_app_cidrs  = local.private_subnet_app_cidrs
  private_subnet_data_cidrs = local.private_subnet_data_cidrs
  private_subnet_mgmt_cidrs = local.private_subnet_mgmt_cidrs
  common_tags          = local.common_tags

  nat_gateway_elastic_ips = var.nat_gateway_elastic_ips

  enable_flow_log = true
  flow_log_destination_type = "cloud-watch-logs"
  flow_log_format = "${version} ${account-id} ${interface-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${packets} ${bytes} ${start} ${end} ${action} ${log-status}"
}

module "security" {
  source = "./modules/security"

  environment          = var.environment
  vpc_id               = module.network.vpc_id
  common_tags          = local.common_tags
  allowed_cidr_blocks  = var.admin_cidr_blocks

  enable_guardduty           = var.enable_guardduty
  enable_security_hub        = var.enable_security_hub
  enable_config              = var.enable_config
  enable_cloudtrail          = var.enable_cloudtrail

  security_hub_standards = ["aws-foundational-security-best-standards", "pci-dss"]

  cloudtrail_bucket_name = var.cloudtrail_bucket_name
  cloudtrail_log_prefix  = "audit-logs"

  s3_buckets_to_protect = [
    "pagos-${var.environment}-audit-logs",
    "pagos-${var.environment}-backups",
    "pagos-${var.environment}-application-data"
  ]

  kms_key_administrators = var.kms_administrator_arns
  kms_key_users          = var.kms_user_arns

  enable_deletion_window = true
  deletion_window_days   = 7
}

module "compute" {
  source = "./modules/compute"

  environment              = var.environment
  vpc_id                   = module.network.vpc_id
  common_tags              = local.common_tags

  public_subnet_ids        = module.network.public_subnet_ids
  private_subnet_app_ids   = module.network.private_subnet_app_ids
  private_subnet_data_ids  = module.network.private_subnet_data_ids
  private_subnet_mgmt_ids  = module.network.private_subnet_mgmt_ids

  instance_type            = var.instance_type
  instance_tenancy         = var.instance_tenancy

  key_name                 = var.ssh_key_name

  asg_min_size             = var.asg_min_size
  asg_max_size             = var.asg_max_size
  asg_desired_capacity     = var.asg_desired_capacity

  asg_health_check_type    = "ELB"
  asg_health_check_period  = 60

  asg_metrics_collection   = ["GroupDesiredCapacity", "GroupInServiceCapacity", "GroupPendingCapacity", "GroupTerminatingCapacity", "GroupTotalCapacity"]

  elb_type                 = "application"
  elb_scheme               = "internet-facing"
  elb_deletion_protection  = true
  elb_enable_cross_zone    = true

  elb_access_logs_bucket   = var.elb_access_logs_bucket

  target_instance_port     = 443
  target_instance_protocol = "HTTPS"

  health_check_path        = "/health"
  health_check_interval    = 30
  health_check_timeout     = 5
  healthy_threshold        = 2
  unhealthy_threshold      = 3

  certificate_arn          = var.certificate_arn

  asg_instance_security_groups = [module.security.instance_security_group_id]

  ebs_volume_size          = var.ebs_volume_size
  ebs_volume_type          = "gp3"
  ebs_encrypted            = true

  ebs_kms_key_id           = module.security.ebs_kms_key_arn

  enable_monitoring        = true
  detailed_monitoring      = true

  lifecycle_hook_name      = "instance-termination-hook"
  lifecycle_hook_timeout   = 300

  scaling_policies = [
    {
      name           = "scale-out-policy"
      adjustment_type = "ChangeInCapacity"
      scaling_adjustment = 2
      cooldown       = 300
      metric_type    = "ASGAverageCPUUtilization"
      threshold      = 70
      statistic      = "Average"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 2
      period          = 60
      action_type     = "add"
    },
    {
      name           = "scale-in-policy"
      adjustment_type = "ChangeInCapacity"
      scaling_adjustment = -1
      cooldown       = 300
      metric_type    = "ASGAverageCPUUtilization"
      threshold      = 30
      statistic      = "Average"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = 2
      period          = 60
      action_type     = "remove"
    }
  ]
}

resource "aws_kms_key" "application" {
  description             = "KMS key for application data encryption in ${var.environment}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_application_policy.json

  tags = merge(local.common_tags, {
    Name        = "application-kms-key-${var.environment}"
    Encryption  = "required"
  })
}

data "aws_iam_policy_document" "kms_application_policy" {
  statement {
    sid = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid = "Allow use of the key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = var.kms_user_arns
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:ListAliases"
    ]
    resources = ["*"]
  }

  statement {
    sid = "Allow key administrators"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = var.kms_administrator_arns
    }
    actions = [
      "kms:Create*",
      "kms:Delete*",
      "kms:Update*",
      "kms:Put*",
      "kms:Revoke*",
      "kms:Enable*",
      "kms:Disable*",
      "kms:List*",
      "kms:Describe*",
      "kms:TagResource",
      "kms:UntagResource"
    ]
    resources = ["*"]
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "application_logs" {
  bucket = "pagos-${var.environment}-application-logs-${data.aws_caller_identity.current.account_id}"

  tags = merge(local.common_tags, {
    Name        = "application-logs-bucket"
    Purpose     = "application-logging"
    Retention   = "90-days"
  })
}

resource "aws_s3_bucket_versioning" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.application.arn
    }
  }
}

resource "aws_s3_bucket_public_access_block" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}

resource "aws_cloudwatch_log_group" "application_logs" {
  name              = "/aws/${var.environment}/pagos/application"
  retention_in_days = 90
  kms_key_id        = aws_kms_key.application.arn

  tags = merge(local.common_tags, {
    Name        = "application-log-group"
    Sensitive   = "false"
  })
}

resource "aws_cloudwatch_log_stream" "application_access" {
  name           = "access-logs"
  log_group_name = aws_cloudwatch_log_group.application_logs.name
}

resource "aws_cloudwatch_log_stream" "application_error" {
  name           = "error-logs"
  log_group_name = aws_cloudwatch_log_group.application_logs.name
}

resource "aws_cloudwatch_log_stream" "application_audit" {
  name           = "audit-logs"
  log_group_name = aws_cloudwatch_log_group.application_logs.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
  alarm_name          = "${var.environment}-high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors EC2 CPU utilization"
  alarm_actions       = [module.compute.scale_out_alarm_arn]

  dimensions = {
    AutoScalingGroupName = module.compute.asg_name
  }

  tags = merge(local.common_tags, {
    Name        = "high-cpu-alarm"
    Severity    = "warning"
  })
}

resource "aws_cloudwatch_metric_alarm" "high_memory_utilization" {
  alarm_name          = "${var.environment}-high-memory-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = 60
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "This metric monitors memory utilization"

  dimensions = {
    AutoScalingGroupName = module.compute.asg_name
  }

  tags = merge(local.common_tags, {
    Name        = "high-memory-alarm"
    Severity    = "warning"
  })
}

resource "aws_cloudwatch_metric_alarm" "target_response_time" {
  alarm_name          = "${var.environment}-target-response-time"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "p95"
  threshold           = 1
  alarm_description   = "ALB target response time exceeds threshold"
  alarm_actions       = [module.compute.scale_out_alarm_arn]

  dimensions = {
    LoadBalancer = module.compute.elb_arn
  }

  tags = merge(local.common_tags, {
    Name        = "target-response-time-alarm"
    Severity    = "warning"
    SLI         = "latency"
  })
}

resource "aws_cloudwatch_metric_alarm" "target_5xx_errors" {
  alarm_name          = "${var.environment}-target-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "TargetConnectionErrorCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "ALB target returns 5xx errors"

  dimensions = {
    LoadBalancer = module.compute.elb_arn
  }

  tags = merge(local.common_tags, {
    Name        = "target-5xx-errors-alarm"
    Severity    = "critical"
    SLI         = "availability"
  })
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-s3"
  })
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-dynamodb"
  })
}

resource "aws_vpc_endpoint" "secrets_manager" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.secretsmanager"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-secrets-manager"
  })
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ssm"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-ssm"
  })
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.logs"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-logs"
  })
}

resource "aws_vpc_endpoint" "sqs" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.sqs"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-sqs"
  })
}

resource "aws_vpc_endpoint" "sns" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.sns"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-sns"
  })
}