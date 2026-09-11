# Outputs del módulo de seguridad

output "elb_security_group_id" {
  description = "ID del grupo de seguridad para el ALB"
  value       = aws_security_group.alb.id
}

output "instance_security_group_id" {
  description = "ID del grupo de seguridad para las instancias de aplicación"
  value       = aws_security_group.app.id
}

output "rds_security_group_id" {
  description = "ID del grupo de seguridad para la base de datos RDS"
  value       = aws_security_group.database.id
}

output "internal_security_group_id" {
  description = "ID del grupo de seguridad interno"
  value       = aws_security_group.bastion.id
}

output "ec2_instance_role_arn" {
  description = "ARN del rol IAM para instancias EC2"
  value       = aws_iam_role.app_instance.arn
}

output "asg_service_role_arn" {
  description = "ARN del rol IAM para el servicio Auto Scaling"
  value       = aws_iam_role.app_instance.arn
}

output "security_kms_key_arn" {
  description = "ARN de la clave KMS de seguridad"
  value       = ""
}

output "ebs_kms_key_arn" {
  description = "ARN de la clave KMS para EBS"
  value       = ""
}

output "app_security_group_arn" {
  description = "ARN del grupo de seguridad de aplicación"
  value       = aws_security_group.app.arn
}

output "db_security_group_arn" {
  description = "ARN del grupo de seguridad de base de datos"
  value       = aws_security_group.database.arn
}

output "instance_profile_name" {
  description = "Nombre del perfil de instancia EC2"
  value       = aws_iam_instance_profile.app.name
}