// Security Group para el servicio de pagos
resource "aws_security_group" "pagos" {
  name        = "${var.environment}-sg-pagos"
  description = "Security Group para el servicio de pagos con reglas de menor privilegio"
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-sg-pagos"
      Description = "SG para servicio de procesamiento de pagos"
      Component   = "Pagos"
      Layer       = "Private"
      Compliance  = "PCI-DSS"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "pagos_ingress_https" {
  security_group_id = aws_security_group.pagos.id
  cidr_ipv4         = var.subnet_pagos_cidr
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Permitir HTTPS desde ALB hacia servicio de pagos"
}

resource "aws_vpc_security_group_ingress_rule" "pagos_ingress_postgres" {
  security_group_id = aws_security_group.pagos.id
  cidr_ipv4         = var.subnet_rds_cidr
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  description       = "Permitir PostgreSQL desde subred de base de datos"
}

resource "aws_vpc_security_group_ingress_rule" "pagos_ingress_monitoring" {
  security_group_id = aws_security_group.pagos.id
  cidr_ipv4         = var.subnet_monitoring_cidr
  from_port         = 9090
  to_port           = 9090
  protocol          = "tcp"
  description       = "Permitir métricas de Prometheus desde subred de monitoreo"
}

resource "aws_vpc_security_group_egress_rule" "pagos_egress_nat" {
  security_group_id = aws_security_group.pagos.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Permitir salida HTTPS hacia internet via NAT para APIs externas"
}

resource "aws_vpc_security_group_egress_rule" "pagos_egress_antifraude" {
  security_group_id = aws_security_group.pagos.id
  cidr_ipv4         = var.subnet_antifraude_cidr
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  description       = "Permitir comunicación con servicio antifraude"
}

resource "aws_vpc_security_group_egress_rule" "pagos_egress_buro" {
  security_group_id = aws_security_group.pagos.id
  cidr_ipv4         = var.subnet_buro_cidr
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  description       = "Permitir comunicación con buró de riesgos"
}

// Security Group para el servicio antifraude
resource "aws_security_group" "antifraude" {
  name        = "${var.environment}-sg-antifraude"
  description = "Security Group para el motor antifraude"
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-sg-antifraude"
      Description = "SG para motor de detección de fraude"
      Component   = "Antifraude"
      Layer       = "Private"
      Compliance  = "PCI-DSS"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "antifraude_ingress_pagos" {
  security_group_id = aws_security_group.antifraude.id
  cidr_ipv4         = var.subnet_pagos_cidr
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  description       = "Permitir requests del servicio de pagos"
}

resource "aws_vpc_security_group_ingress_rule" "antifraude_ingress_ml" {
  security_group_id = aws_security_group.antifraude.id
  cidr_ipv4         = var.subnet_antifraude_cidr
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  description       = "Permitir inferencia de modelo ML interno"
}

resource "aws_vpc_security_group_egress_rule" "antifraude_egress_dynamodb" {
  security_group_id = aws_security_group.antifraude.id
  cidr_ipv4         = var.subnet_antifraude_cidr
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Permitir acceso a DynamoDB para cache de decisiones"
}

// Security Group para el buró de riesgos
resource "aws_security_group" "buro_riesgos" {
  name        = "${var.environment}-sg-buro-riesgos"
  description = "Security Group para el buró de riesgos externo"
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-sg-buro-riesgos"
      Description = "SG para consulta a buró de riesgos"
      Component   = "BuroRiesgos"
      Layer       = "Private"
      Compliance  = "PCI-DSS"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "buro_ingress_pagos" {
  security_group_id = aws_security_group.buro_riesgos.id
  cidr_ipv4         = var.subnet_pagos_cidr
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  description       = "Permitir requests del servicio de pagos"
}

resource "aws_vpc_security_group_egress_rule" "buro_egress_external" {
  security_group_id = aws_security_group.buro_riesgos.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Permitir salida hacia API externa del buró"
}

// Security Group para el sistema de liquidación
resource "aws_security_group" "liquidacion" {
  name        = "${var.environment}-sg-liquidacion"
  description = "Security Group para el sistema de liquidación"
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-sg-liquidacion"
      Description = "SG para sistema de liquidación de transacciones"
      Component   = "Liquidacion"
      Layer       = "Private"
      Compliance  = "PCI-DSS"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "liquidacion_ingress_pagos" {
  security_group_id = aws_security_group.liquidacion.id
  cidr_ipv4         = var.subnet_pagos_cidr
  from_port         = 8082
  to_port           = 8082
  protocol          = "tcp"
  description       = "Permitir eventos de transacción completada desde pagos"
}

resource "aws_vpc_security_group_ingress_rule" "liquidacion_ingress_antifraude" {
  security_group_id = aws_security_group.liquidacion.id
  cidr_ipv4         = var.subnet_antifraude_cidr
  from_port         = 8082
  to_port           = 8082
  protocol          = "tcp"
  description       = "Permitir resultados de riesgo desde antifraude"
}

resource "aws_vpc_security_group_egress_rule" "liquidacion_egress_rds" {
  security_group_id = aws_security_group.liquidacion.id
  cidr_ipv4         = var.subnet_rds_cidr
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  description       = "Permitir escritura a base de datos de liquidación"
}

resource "aws_vpc_security_group_egress_rule" "liquidacion_egress_s3" {
  security_group_id = aws_security_group.liquidacion.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Permitir escritura a S3 para reportes"
}

output "sg_pagos_id" {
  description = "ID del Security Group de pagos"
  value       = aws_security_group.pagos.id
}

output "sg_antifraude_id" {
  description = "ID del Security Group de antifraude"
  value       = aws_security_group.antifraude.id
}

output "sg_buro_riesgos_id" {
  description = "ID del Security Group del buró de riesgos"
  value       = aws_security_group.buro_riesgos.id
}

output "sg_liquidacion_id" {
  description = "ID del Security Group de liquidación"
  value       = aws_security_group.liquidacion.id
}