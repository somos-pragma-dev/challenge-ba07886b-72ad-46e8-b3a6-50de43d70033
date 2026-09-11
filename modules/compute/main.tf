# Módulo de cómputo: define EC2, ASG, ALB, Lambda y monitoreo

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# Launch Template para el gateway de pagos
resource "aws_launch_template" "payment_gateway_lt" {
  name_prefix   = "payment-gateway-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.payment_gateway_instance_type

  iam_instance_profile {
    name = var.ec2_instance_profile_name
  }

  vpc_security_group_ids = [var.web_security_group_id, var.app_security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker nginx
              systemctl enable docker
              systemctl start docker
              EOF
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "payment-gateway"
      Environment = var.environment
      Component   = "payment-gateway"
      Tier        = "application"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group para el gateway de pagos
resource "aws_autoscaling_group" "payment_gateway_asg" {
  name                = "payment-gateway-asg-${var.environment}"
  vpc_zone_identifier = var.private_subnet_ids
  desired_capacity    = var.payment_gateway_desired_capacity
  min_size            = var.payment_gateway_min_size
  max_size            = var.payment_gateway_max_size
  health_check_type   = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.payment_gateway_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "payment-gateway-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Component"
    value               = "payment-gateway"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Políticas de auto scaling
resource "aws_autoscaling_policy" "payment_gateway_scale_up" {
  name                   = "payment-gateway-scale-up"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.payment_gateway_asg.name
}

resource "aws_autoscaling_policy" "payment_gateway_scale_down" {
  name                   = "payment-gateway-scale-down"
  scaling_adjustment     = -2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.payment_gateway_asg.name
}

# ALB público para el gateway de pagos
resource "aws_lb" "public_alb" {
  name               = "payment-gateway-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = var.environment == "prod" ? true : false

  tags = {
    Name        = "payment-gateway-public-alb"
    Environment = var.environment
    Component   = "payment-gateway"
  }
}

# Target group para el gateway de pagos
resource "aws_lb_target_group" "payment_gateway_tg" {
  name     = "payment-gateway-tg-${var.environment}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  target_type = "instance"
}

# Listener HTTPS para el ALB
resource "aws_lb_listener" "payment_gateway_https" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.payment_gateway_tg.arn
  }
}

# Listener HTTP con redirect a HTTPS
resource "aws_lb_listener" "payment_gateway_http_redirect" {
  load_balancer_arn = aws_lb.public_alb.arn
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

# Alarma CloudWatch para CPU alto
resource "aws_cloudwatch_metric_alarm" "payment_gateway_cpu_high" {
  alarm_name          = "payment-gateway-cpu-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "75"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.payment_gateway_asg.name
  }

  alarm_actions = var.autoscaling_topic_arn != "" ? [var.autoscaling_topic_arn] : []
  ok_actions    = var.autoscaling_topic_arn != "" ? [var.autoscaling_topic_arn] : []

  tags = {
    Environment = var.environment
    Component   = "payment-gateway"
  }
}

# Alarma CloudWatch para requests por target
resource "aws_cloudwatch_metric_alarm" "payment_gateway_request_count" {
  alarm_name          = "payment-gateway-request-count-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "RequestCountPerTarget"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "10000"

  dimensions = {
    LoadBalancer = aws_lb.public_alb.arn_suffix
    TargetGroup  = aws_lb_target_group.payment_gateway_tg.arn_suffix
  }

  alarm_actions = var.autoscaling_topic_arn != "" ? [var.autoscaling_topic_arn] : []

  tags = {
    Environment = var.environment
    Component   = "payment-gateway"
  }
}