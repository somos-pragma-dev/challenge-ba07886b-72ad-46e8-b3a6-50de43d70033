# Módulo de red: define la topología de VPC, subredes, gateways y tablas de rutas
# Segmentación de red para entorno de pagos con alta disponibilidad

# VPC principal del entorno de pagos
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name        = "${var.project_name}-vpc-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Internet Gateway para salida a internet desde subredes públicas
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.project_name}-igw-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Elastic IP para NAT Gateway en cada AZ
resource "aws_eip" "nat_gateway_eip" {
  count  = length(var.availability_zones)
  domain = "vpc"
  tags = {
    Name        = "${var.project_name}-nat-eip-${var.availability_zones[count.index]}"
    Environment = var.environment
  }
  depends_on = [aws_internet_gateway.main]
}

# NAT Gateways en cada zona de disponibilidad para salida a internet desde subredes privadas
resource "aws_nat_gateway" "main" {
  count         = length(var.availability_zones)
  allocation_id = aws_eip.nat_gateway_eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name        = "${var.project_name}-nat-${var.availability_zones[count.index]}"
    Environment = var.environment
    Project     = var.project_name
  }
  depends_on = [aws_internet_gateway.main]
}

# Subredes públicas para ALB y componentes que requieren acceso a internet
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name        = "${var.project_name}-public-subnet-${var.availability_zones[count.index]}"
    Type        = "public"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Subredes privadas para instancias de aplicación (gateway de pagos, liquidación, antifraude)
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name        = "${var.project_name}-private-subnet-${var.availability_zones[count.index]}"
    Type        = "private"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Subredes de base de datos en capa aislada
resource "aws_subnet" "database" {
  count             = length(var.database_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name        = "${var.project_name}-database-subnet-${var.availability_zones[count.index]}"
    Type        = "database"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Grupo de subredes de base de datos para RDS Multi-AZ
resource "aws_subnet_group" "database" {
  name       = "${var.project_name}-db-subnet-group-${var.environment}"
  subnet_ids = aws_subnet.database[*].id
  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Environment = var.environment
  }
}

# Tabla de rutas pública: tráfico directo a Internet Gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name        = "${var.project_name}-public-rt-${var.environment}"
    Type        = "public"
    Environment = var.environment
  }
}

# Tablas de rutas privadas: tráfico a través de NAT Gateway por AZ
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }
  tags = {
    Name        = "${var.project_name}-private-rt-${var.availability_zones[count.index]}"
    Type        = "private"
    Environment = var.environment
  }
}

# Asociación de subredes públicas con tabla de rutas pública
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Asociación de subredes privadas con sus tablas de rutas por AZ
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}