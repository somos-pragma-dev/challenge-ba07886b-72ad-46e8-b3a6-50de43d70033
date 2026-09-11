output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "aws_region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.network.vpc_cidr
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = module.network.vpc_arn
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "private_subnet_app_ids" {
  description = "IDs of the private subnets for application layer"
  value       = module.network.private_subnet_app_ids
}

output "private_subnet_data_ids" {
  description = "IDs of the private subnets for data layer"
  value       = module.network.private_subnet_data_ids
}

output "private_subnet_mgmt_ids" {
  description = "IDs of the private subnets for management layer"
  value       = module.network.private_subnet_mgmt_ids
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways"
  value       = module.network.nat_gateway_ids
}

output "nat_gateway_elastic_ips" {
  description = "Elastic IPs assigned to NAT Gateways"
  value       = module.network.nat_gateway_elastic_ips
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.network.igw_id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.network.public_route_table_id
}

output "private_route_table_ids" {
  description = "IDs of the private route tables"
  value       = module.network.private_route_table_ids
}

output "security_group_ids" {
  description = "Map of security group IDs"
  value = {
    elb_security_group_id      = module.security.elb_security_group_id
    instance_security_group_id = module.security.instance_security_group_id
    rds_security_group_id      = module.security.rds_security_group_id
    internal_security_group_id = module.security.internal_security_group_id
  }
}

output "iam_role_arns" {
  description = "Map of IAM role ARNs"
  value = {
    ec2_instance_role_arn = module.security.ec2_instance_role_arn
    asg_service_role_arn  = module.security.asg_service_role_arn
  }
}

output "kms_key_arns" {
  description = "Map of KMS key ARNs"
  value = {
    security_kms_key_arn = module.security.security_kms_key_arn
    ebs_kms_key_arn      = module.security.ebs_kms_key_arn
    application_kms_key_arn = aws_kms_key.application.arn
  }
}

output "application_log_group_name" {
  description = "CloudWatch log group name for application logs"
  value       = aws_cloudwatch_log_group.application_logs.name
}

output "application_logs_bucket_name" {
  description = "S3 bucket name for application logs"
  value       = aws_s3_bucket.application_logs.id
}

output "elb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.compute.elb_dns_name
}

output "elb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.compute.elb_arn
}

output "elb_zone_id" {
  description = "Zone ID of the ALB for Route 53 alias"
  value       = module.compute.elb_zone_id
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.compute.asg_name
}

output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = module.compute.asg_arn
}

output "instance_ids" {
  description = "IDs of EC2 instances in the ASG"
  value       = module.compute.instance_ids
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = module.compute.launch_template_id
}

output "target_group_arn" {
  description = "ARN of the ALB target group"
  value       = module.compute.target_group_arn
}

output "vpc_endpoints" {
  description = "Map of VPC endpoint IDs"
  value = {
    s3            = aws_vpc_endpoint.s3.id
    dynamodb      = aws_vpc_endpoint.dynamodb.id
    secrets_manager = aws_vpc_endpoint.secrets_manager.id
    ssm           = aws_vpc_endpoint.ssm.id
    cloudwatch_logs = aws_vpc_endpoint.cloudwatch_logs.id
    sqs           = aws_vpc_endpoint.sqs.id
    sns           = aws_vpc_endpoint.sns.id
  }
}

output "cloudwatch_alarm_arns" {
  description = "Map of CloudWatch alarm ARNs"
  value = {
    high_cpu_alarm       = aws_cloudwatch_metric_alarm.high_cpu_utilization.arn
    high_memory_alarm    = aws_cloudwatch_metric_alarm.high_memory_utilization.arn
    target_response_time = aws_cloudwatch_metric_alarm.target_response_time.arn
    target_5xx_errors    = aws_cloudwatch_metric_alarm.target_5xx_errors.arn
  }
}

output "account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "all_public_subnet_cidrs" {
  description = "CIDR blocks of all public subnets"
  value       = local.public_subnet_cidrs
}

output "all_private_subnet_app_cidrs" {
  description = "CIDR blocks of all private application subnets"
  value       = local.private_subnet_app_cidrs
}

output "all_private_subnet_data_cidrs" {
  description = "CIDR blocks of all private data subnets"
  value       = local.private_subnet_data_cidrs
}

output "all_private_subnet_mgmt_cidrs" {
  description = "CIDR blocks of all private management subnets"
  value       = local.private_subnet_mgmt_cidrs
}