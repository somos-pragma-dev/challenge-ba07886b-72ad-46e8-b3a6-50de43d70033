# Módulo de seguridad: políticas IAM, grupos de seguridad y NACLs
# Aplicación del principio de menor privilegio para entorno de pagos

# Grupo de seguridad para ALB público: permite tráfico HTTP/HTTPS desde internet
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg-${var.environment}"
  description = "Grupo de seguridad para Application Load Balancer público"
  vpc_id      = var.vpc_id
  tags = {
    Name        = "${var.project_name}-alb-sg"
    Environment = var.environment
    Component   = "alb"
  }
}

# Grupo de seguridad para instancias de aplicación (gateway de pagos, liquidación, antifraude)
resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg-${var.environment}"
  description = "Grupo de seguridad para instancias de aplicación"
  vpc_id      = var.vpc_id
  tags = {
    Name        = "${var.project_name}-app-sg"
    Environment = var.environment
    Component   = "application"
  }
}

# Grupo de seguridad para base de datos RDS
resource "aws_security_group" "database" {
  name        = "${var.project_name}-db-sg-${var.environment}"
  description = "Grupo de seguridad para base de datos"
  vpc_id      = var.vpc_id
  tags = {
    Name        = "${var.project_name}-db-sg"
    Environment = var.environment
    Component   = "database"
  }
}

# Grupo de seguridad para bastion host (acceso administrativo)
resource "aws_security_group" "bastion" {
  name        = "${var.project_name}-bastion-sg-${var.environment}"
  description = "Grupo de seguridad para bastion host"
  vpc_id      = var.vpc_id
  tags = {
    Name        = "${var.project_name}-bastion-sg"
    Environment = var.environment
    Component   = "bastion"
  }
}

# Regla de entrada: HTTPS desde cualquier lugar para ALB
resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Permitir HTTPS desde internet"
}

# Regla de entrada: HTTP desde cualquier lugar para ALB
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Permitir HTTP desde internet"
}

# Regla de entrada: solo desde ALB hacia app
resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = 8443
  to_port                      = 8443
  ip_protocol                  = "tcp"
  description                  = "Permitir tráfico del ALB"
}

# Regla de entrada: SSH desde bastion hacia app
resource "aws_vpc_security_group_ingress_rule" "app_from_bastion" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.bastion.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  description                  = "Permitir SSH desde bastion"
}

# Regla de entrada: MySQL/PostgreSQL solo desde grupo de aplicación
resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id            = aws_security_group.database.id
  referenced_security_group_id = aws_security_group.app.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  description                  = "Permitir MySQL desde aplicaciones"
}

# Regla de entrada: SSH solo desde IP corporativo
resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = var.bastion_ssh_cidr
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Permitir SSH desde IP corporativo"
}

# NACL para subredes públicas: permitir tráfico entrante/saliente básico
resource "aws_network_acl" "public" {
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids
  tags = {
    Name        = "${var.project_name}-nacl-public"
    Environment = var.environment
  }
}

# Regla entrante NACL pública: HTTPS
resource "aws_network_acl_rule" "public_https_in" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  action         = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Regla entrante NACL pública: HTTP
resource "aws_network_acl_rule" "public_http_in" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  from_port      = 80
  to_port        = 80
  action         = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Regla saliente NACL pública: tráfico efímero
resource "aws_network_acl_rule" "public_ephemeral_out" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  from_port      = 1024
  to_port        = 65535
  action         = "allow"
  cidr_block     = "0.0.0.0/0"
}

# NACL para subredes privadas: restringir tráfico
resource "aws_network_acl" "private" {
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids
  tags = {
    Name        = "${var.project_name}-nacl-private"
    Environment = var.environment
  }
}

# Regla entrante NACL privada: permitir tráfico desde VPC
resource "aws_network_acl_rule" "private_app_in" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  from_port      = 0
  to_port        = 65535
  action         = "allow"
  cidr_block     = var.vpc_cidr
}

# Regla saliente NACL privada: hacia internet vía NAT
resource "aws_network_acl_rule" "private_nat_out" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  action         = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Política IAM para rol de EC2 de aplicación con menor privilegio
resource "aws_iam_role" "app_instance" {
  name = "${var.project_name}-app-instance-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
  tags = {
    Environment = var.environment
  }
}

# Política IAM: acceso a CloudWatch Logs para aplicaciones
resource "aws_iam_policy" "app_cloudwatch" {
  name        = "${var.project_name}-cloudwatch-policy-${var.environment}"
  description = "Política para escritura de logs en CloudWatch"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "arn:aws:logs:${var.region}:${var.account_id}:log-group:/${var.project_name}/${var.environment}/*"
    }]
  })
}

# Adjuntar política CloudWatch al rol
resource "aws_iam_role_policy_attachment" "app_cloudwatch_attach" {
  role       = aws_iam_role.app_instance.name
  policy_arn = aws_iam_policy.app_cloudwatch.arn
}

# Política IAM: acceso a S3 para almacenamiento de logs (solo bucket específico)
resource "aws_iam_policy" "app_s3" {
  name        = "${var.project_name}-s3-policy-${var.environment}"
  description = "Política para acceso a S3 con menor privilegio"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:PutObject",
        "s3:GetObject"
      ]
      Resource = "arn:aws:s3:::${var.logs_bucket_name}/*"
    }]
  })
}

# Adjuntar política S3 al rol
resource "aws_iam_role_policy_attachment" "app_s3_attach" {
  role       = aws_iam_role.app_instance.name
  policy_arn = aws_iam_policy.app_s3.arn
}

# Perfil de instancia EC2
resource "aws_iam_instance_profile" "app" {
  name = "${var.project_name}-app-instance-profile-${var.environment}"
  role = aws_iam_role.app_instance.name
  tags = {
    Environment = var.environment
  }
}