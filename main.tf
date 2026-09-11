terraform {
  required_version = ">= 1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "red-pagos-segura"
      ManagedBy   = "terraform"
      Environment = var.environment
      CostCenter  = var.cost_center
    }
  }
}

# =============================================================================
# VPC PRINCIPAL - Red virtual aislada para el entorno de pagos
# =============================================================================
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc-principal"
    Description = "VPC principal para el entorno de pagos - ${var.environment}"
    Tier        = "network"
  }
}

# =============================================================================
# SUBREDES PÚBLICAS - Servicios de monitoreo y auditoría
# Segmentadas por AZ para alta disponibilidad
# =============================================================================
resource "aws_subnet" "public_payments" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_payments_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-payments-az1"
    Description = "Subred pública para servicios de pagos"
    Type        = "public"
    Service     = "payments"
    Tier        = "public"
  }
}

resource "aws_subnet" "public_payments_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_payments_cidr_az2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-payments-az2"
    Description = "Subred pública para servicios de pagos - AZ2"
    Type        = "public"
    Service     = "payments"
    Tier        = "public"
  }
}

resource "aws_subnet" "public_monitoring" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_monitoring_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-monitoring-az1"
    Description = "Subred pública para servicios de monitoreo"
    Type        = "public"
    Service     = "monitoring"
    Tier        = "public"
  }
}

resource "aws_subnet" "public_monitoring_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_monitoring_cidr_az2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-monitoring-az2"
    Description = "Subred pública para servicios de monitoreo - AZ2"
    Type        = "public"
    Service     = "monitoring"
    Tier        = "public"
  }
}

# =============================================================================
# SUBREDES PRIVADAS - Servicios de pago, base de datos y procesamiento
# Sin acceso directo desde internet
# =============================================================================
resource "aws_subnet" "private_payments" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_payments_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "${var.environment}-private-payments-az1"
    Description = "Subred privada para servicios de pago"
    Type        = "private"
    Service     = "payments"
    Tier        = "application"
  }
}

resource "aws_subnet" "private_payments_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_payments_cidr_az2
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name        = "${var.environment}-private-payments-az2"
    Description = "Subred privada para servicios de pago - AZ2"
    Type        = "private"
    Service     = "payments"
    Tier        = "application"
  }
}

resource "aws_subnet" "private_database" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_database_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "${var.environment}-private-database-az1"
    Description = "Subred privada para bases de datos"
    Type        = "private"
    Service     = "database"
    Tier        = "data"
  }
}

resource "aws_subnet" "private_database_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_database_cidr_az2
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name        = "${var.environment}-private-database-az2"
    Description = "Subred privada para bases de datos - AZ2"
    Type        = "private"
    Service     = "database"
    Tier        = "data"
  }
}

resource "aws_subnet" "private_audit" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_audit_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "${var.environment}-private-audit-az1"
    Description = "Subred privada para servicios de auditoría"
    Type        = "private"
    Service     = "audit"
    Tier        = "application"
  }
}

resource "aws_subnet" "private_audit_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_audit_cidr_az2
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name        = "${var.environment}-private-audit-az2"
    Description = "Subred privada para servicios de auditoría - AZ2"
    Type        = "private"
    Service     = "audit"
    Tier        = "application"
  }
}

# =============================================================================
# GATEWAY DE INTERNET - Conexión desde subredes públicas a internet
# =============================================================================
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-igw-principal"
    Description = "Internet Gateway para acceso a internet desde subredes públicas"
  }
}

# =============================================================================
# NAT GATEWAYS - Permite salida a internet desde subredes privadas
# Sin permitir ingresos de tráfico desde internet
# Desplegado en subredes públicas para alta disponibilidad
# =============================================================================
resource "aws_nat_gateway" "main_az1" {
  allocation_id = aws_eip.nat_eip_az1.id
  subnet_id     = aws_subnet.public_payments.id

  tags = {
    Name        = "${var.environment}-nat-gateway-az1"
    Description = "NAT Gateway para tráfico saliente desde subredes privadas - AZ1"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main_az2" {
  allocation_id = aws_eip.nat_eip_az2.id
  subnet_id     = aws_subnet.public_payments_az2.id

  tags = {
    Name        = "${var.environment}-nat-gateway-az2"
    Description = "NAT Gateway para tráfico saliente desde subredes privadas - AZ2"
  }

  depends_on = [aws_internet_gateway.main]
}

# =============================================================================
# ELASTIC IPs - Direcciones IP elásticas para NAT Gateways
# =============================================================================
resource "aws_eip" "nat_eip_az1" {
  domain = "vpc"

  tags = {
    Name        = "${var.environment}-eip-nat-az1"
    Description = "EIP para NAT Gateway en AZ1"
  }
}

resource "aws_eip" "nat_eip_az2" {
  domain = "vpc"

  tags = {
    Name        = "${var.environment}-eip-nat-az2"
    Description = "EIP para NAT Gateway en AZ2"
  }
}

# =============================================================================
# TABLAS DE RUTAS - Control de tráfico de red
# =============================================================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.environment}-rt-publica"
    Description = "Tabla de rutas para subredes públicas - acceso a internet"
  }
}

resource "aws_route_table" "private_az1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_az1.id
  }

  tags = {
    Name        = "${var.environment}-rt-privada-az1"
    Description = "Tabla de rutas para subredes privadas AZ1 - salida via NAT"
  }
}

resource "aws_route_table" "private_az2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_az2.id
  }

  tags = {
    Name        = "${var.environment}-rt-privada-az2"
    Description = "Tabla de rutas para subredes privadas AZ2 - salida via NAT"
  }
}

# =============================================================================
# ASOCIACIONES DE TABLAS DE RUTAS - Conectar subredes a tablas de rutas
# =============================================================================
resource "aws_route_table_association" "public_payments" {
  subnet_id      = aws_subnet.public_payments.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_payments_az2" {
  subnet_id      = aws_subnet.public_payments_az2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_monitoring" {
  subnet_id      = aws_subnet.public_monitoring.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_monitoring_az2" {
  subnet_id      = aws_subnet.public_monitoring_az2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_payments" {
  subnet_id      = aws_subnet.private_payments.id
  route_table_id = aws_route_table.private_az1.id
}

resource "aws_route_table_association" "private_payments_az2" {
  subnet_id      = aws_subnet.private_payments_az2.id
  route_table_id = aws_route_table.private_az2.id
}

resource "aws_route_table_association" "private_database" {
  subnet_id      = aws_subnet.private_database.id
  route_table_id = aws_route_table.private_az1.id
}

resource "aws_route_table_association" "private_database_az2" {
  subnet_id      = aws_subnet.private_database_az2.id
  route_table_id = aws_route_table.private_az2.id
}

resource "aws_route_table_association" "private_audit" {
  subnet_id      = aws_subnet.private_audit.id
  route_table_id = aws_route_table.private_az1.id
}

resource "aws_route_table_association" "private_audit_az2" {
  subnet_id      = aws_subnet.private_audit_az2.id
  route_table_id = aws_route_table.private_az2.id
}

# =============================================================================
# DATA SOURCES - Información de disponibilidad de AZs
# =============================================================================
data "aws_availability_zones" "available" {
  state = "available"
}