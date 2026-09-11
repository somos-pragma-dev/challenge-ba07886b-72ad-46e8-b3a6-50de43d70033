resource "aws_lb" "pagos_public_alb" {
  name               = "pagos-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_pagos.id]
  subnets            = var.public_subnet_ids
  enable_deletion_protection = var.environment == "prod" ? true : false
  idle_timeout       = 60
  enable_cross_zone_load_balancing = true
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-public-alb"
      Description = "ALB público para servicios de monitoreo y auditoría del sistema de pagos"
      Tier        = "Application"
    }
  )
}
resource "aws_security_group" "alb_pagos" {
  name        = "sg-alb-pagos"
  description = "Security group para ALB público del sistema de pagos"
  vpc_id      = var.vpc_id
  ingress {
    description = "HTTPS desde internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0/0"]
  }
  ingress {
    description = "HTTP para redirección a HTTPS"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0/0"]
  }
  egress {
    description = "Tráfico a servicios backend"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [var.app_security_group_id]
  }
  egress {
    description = "Salida a internet para health checks"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0/0"]
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "sg-alb-pagos"
      Description = "SG para ALB público - acceso HTTPS desde internet"
    }
  )
}
resource "aws_lb_target_group" "monitoreo_tg" {
  name     = "pagos-monitoreo-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    var.common_tags,
    {
      Name = "pagos-monitoreo-tg"
    }
  )
}
resource "aws_lb_target_group" "auditoria_tg" {
  name     = "pagos-auditoria-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/api/health"
    matcher             = "200"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    var.common_tags,
    {
      Name = "pagos-auditoria-tg"
    }
  )
}
resource "aws_acm_certificate" "pagos_alb_cert" {
  provider          = aws.us_east_1
  domain_name       = var.alb_domain_name
  validation_method = "DNS"
  subject_alternative_names = var.alb_subject_alternative_names
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    var.common_tags,
    {
      Name = "pagos-alb-cert"
    }
  )
}
resource "aws_lb_listener" "https_monitoring" {
  load_balancer_arn = aws_lb.pagos_public_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.pagos_alb_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.monitoreo_tg.arn
  }
}
resource "aws_lb_listener" "https_auditoria" {
  load_balancer_arn = aws_lb.pagos_public_alb.arn
  port              = "8443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.pagos_alb_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.auditoria_tg.arn
  }
}
resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.pagos_public_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener_rule" "monitoreo_path_based" {
  listener_arn = aws_lb_listener.https_monitoring.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.monitoreo_tg.arn
  }
  condition {
    path_pattern {
      values = ["/monitoreo/*", "/metrics/*"]
    }
  }
}
resource "aws_lb_listener_rule" "auditoria_path_based" {
  listener_arn = aws_lb_listener.https_auditoria.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.auditoria_tg.arn
  }
  condition {
    path_pattern {
      values = ["/auditoria/*", "/logs/*"]
    }
  }
}
resource "aws_lb" "pagos_internal_alb" {
  name               = "pagos-internal-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_internal_pagos.id]
  subnets            = var.private_subnet_ids
  enable_deletion_protection = var.environment == "prod" ? true : false
  idle_timeout       = 60
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-internal-alb"
      Description = "ALB interno para servicios de pagos"
    }
  )
}
resource "aws_security_group" "alb_internal_pagos" {
  name        = "sg-alb-internal-pagos"
  description = "Security group para ALB interno del sistema de pagos"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Acceso desde subredes privadas"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = var.private_subnet_cidrs
  }
  egress {
    description = "Tráfico a servicios backend"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [var.app_security_group_id]
  }
  tags = merge(
    var.common_tags,
    {
      Name = "sg-alb-internal-pagos"
    }
  )
}
resource "aws_lb_target_group" "pagos_api_tg" {
  name     = "pagos-api-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 30
    path                = "/api/v1/health"
    matcher             = "200"
  }
  stickiness {
    enabled         = true
    cookie_duration = 3600
    type            = "lb_cookie"
  }
  tags = merge(
    var.common_tags,
    {
      Name = "pagos-api-tg"
    }
  )
}
resource "aws_lb_listener" "https_internal_pagos" {
  load_balancer_arn = aws_lb.pagos_internal_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-13-2021-06"
  certificate_arn   = aws_acm_certificate.pagos_alb_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pagos_api_tg.arn
  }
}
resource "aws_cloudwatch_metric_alarm" "alb_target_response_time" {
  alarm_name          = "pagos-alb-response-time-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm cuando el tiempo de respuesta del ALB supera 1 segundo"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  dimensions = {
    LoadBalancer = aws_lb.pagos_public_alb.arn_suffix
  }
  tags = var.common_tags
}
resource "aws_cloudwatch_metric_alarm" "alb_target_healthy_hosts" {
  alarm_name          = "pagos-alb-healthy-hosts-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "Alarm cuando hay menos de 1 host sano en el target group"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  dimensions = {
    LoadBalancer = aws_lb.pagos_public_alb.arn_suffix
    TargetGroup  = aws_lb_target_group.monitoreo_tg.arn_suffix
  }
  tags = var.common_tags
}