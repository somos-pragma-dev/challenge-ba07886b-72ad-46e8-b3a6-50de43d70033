# Outputs del módulo de cómputo

output "elb_dns_name" {
  description = "DNS name del ALB público"
  value       = aws_lb.public_alb.dns_name
}

output "elb_arn" {
  description = "ARN del ALB público"
  value       = aws_lb.public_alb.arn
}

output "elb_zone_id" {
  description = "Zone ID del ALB público"
  value       = aws_lb.public_alb.zone_id
}

output "asg_name" {
  description = "Nombre del ASG"
  value       = aws_autoscaling_group.payment_gateway_asg.name
}

output "asg_arn" {
  description = "ARN del ASG"
  value       = aws_autoscaling_group.payment_gateway_asg.arn
}

output "instance_ids" {
  description = "IDs de las instancias del ASG"
  value       = []
}

output "launch_template_id" {
  description = "ID del launch template"
  value       = aws_launch_template.payment_gateway_lt.id
}

output "target_group_arn" {
  description = "ARN del target group"
  value       = aws_lb_target_group.payment_gateway_tg.arn
}

output "scale_out_alarm_arn" {
  description = "ARN de la alarma de scale out"
  value       = aws_cloudwatch_metric_alarm.payment_gateway_cpu_high.arn
}

output "elb_security_group_id" {
  description = "ID del security group del ALB"
  value       = var.web_security_group_id
}