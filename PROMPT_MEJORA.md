# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Boilerplate del stack que falta

Sin esto no compila ni arranca. Es andamiaje, no toca nada de lo pedagogico:

- **providers.tf** — Sin providers.tf, terraform init no sabe que proveedor bajar y no puede inicializar.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `providers.tf`
- `providers.tf`

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad AWS, Tecnología Terraform AWS, Advanced

### Brecha de conocimiento
Diseña segmentacion de red con subredes publicas y privadas aplicando el principio de menor privilegio en las identidades

### Misión / candidato
Definir la red del entorno de pagos

### Reto
- Tema: topologia de red segura en la nube
- Seniority: advanced-l2
- Tipo: practical
- Título: Diseño de red segura en entorno de pagos
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Exploración del dominio y requisitos — objetivo: Identificar los requisitos de red y las restricciones del dominio de pagos — entregable (NO resolver): Documento que describe los requisitos de red y las restricciones del dominio.
- Fase 2: Diseño de la topología de red — objetivo: Diseñar una topología de red segura con subredes públicas y privadas — entregable (NO resolver): Diagrama de la topología de red que muestra las subredes, servicios y rutas de comunicación.
- Fase 3: Evaluación y optimización de la topología de red — objetivo: Evaluar y optimizar la topología de red para cumplir con los requisitos de rendimiento y seguridad — entregable (NO resolver): Documento que describe la evaluación y optimización de la topología de red, incluyendo propuestas de mejora y medidas de seguridad adicionales.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    bucket         = "tf-state-payments-network"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tf-state-lock"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "pagos-seguros"
      ManagedBy   = "terraform"
      Environment = var.environment
      CostCenter  = var.cost_center
    }
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = true
}

provider "aws" {
  alias  = "secondary_region"
  region = var.secondary_region

  default_tags {
    tags = {
      Project     = "pagos-seguros"
      ManagedBy   = "terraform"
      Environment = var.environment
      CostCenter  = var.cost_center
    }
  }
}

provider "kubernetes" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = var.eks_cluster_ca_cert
  token                  = var.eks_cluster_token
  load_config_file       = false
}
// === ARCHIVO: variables.tf ===
variable "aws_region" {
  description = "Región primaria de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "secondary_region" {
  description = "Región secundaria de AWS para redundancia geográfica"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, qa, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El entorno debe ser uno de: dev, qa, prod"
  }
}

variable "cost_center" {
  description = "Centro de costos para etiquetado y optimización de gastos"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para nomenclatura de recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR principal para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El CIDR de la VPC debe ser una dirección de red válida"
  }
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para la región primaria"
  type        = list(string)
}

variable "secondary_availability_zones" {
  description = "Zonas de disponibilidad para la región secundaria"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs_pagos" {
  description = "Bloques CIDR para subredes privadas del dominio de pagos"
  type        = list(string)
}

variable "private_subnet_cidrs_monitoreo" {
  description = "Bloques CIDR para subredes privadas de monitoreo"
  type        = list(string)
}

variable "private_subnet_cidrs_auditoria" {
  description = "Bloques CIDR para subredes privadas de auditoría"
  type        = list(string)
}

variable "nat_gateway_count" {
  description = "Cantidad de NAT Gateways a desplegar (1 por AZ o 1 único)"
  type        = number
  validation {
    condition     = var.nat_gateway_count >= 1 && var.nat_gateway_count <= 3
    error_message = "La cantidad de NAT Gateways debe estar entre 1 y 3"
  }
}

variable "enable_vpn_gateway" {
  description = "Habilitar VPN Gateway para acceso seguro a la VPC"
  type        = bool
  default     = false
}

variable "enable_transit_gateway" {
  description = "Habilitar Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR autorizados para acceso a servicios públicos"
  type        = list(string)
}

variable "enable_flow_logs" {
  description = "Habilitar VPC Flow Logs para observabilidad del tráfico"
  type        = bool
  default     = true
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para VPC Flow Logs (s3, cloud-watch-logs)"
  type        = string
  default     = "s3"
  validation {
    condition     = contains(["s3", "cloud-watch-logs"], var.flow_log_destination_type)
    error_message = "El tipo de destino debe ser s3 o cloud-watch-logs"
  }
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas adicionales para todos los recursos"
  type        = map(string)
  default     = {}
}

variable "s3_bucket_prefix" {
  description = "Prefijo para nombres de buckets S3"
  type        = string
}

variable "rds_instance_class" {
  description = "Clase de instancia RDS para la base de datos de pagos"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Almacenamiento allocated para RDS en GB"
  type        = number
}

variable "rds_multi_az" {
  description = "Habilitar despliegue Multi-AZ para RDS"
  type        = bool
  default     = true
}

variable "lambda_runtime" {
  description = "Runtime para funciones Lambda"
  type        = string
  default     = "python3.11"
}

variable "lambda_memory_size" {
  description = "Memoria en MB para funciones Lambda"
  type        = number
  default     = 256
}

variable "lambda_timeout" {
  description = "Timeout en segundos para funciones Lambda"
  type        = number
  default     = 30
}

variable "alb_timeout" {
  description = "Timeout de respuesta del ALB en segundos"
  type        = number
  default     = 60
}

variable "alb_deletion_protection" {
  description = "Habilitar protección contra eliminación del ALB"
  type        = bool
  default     = true
}

variable "kms_key_administrators" {
  description = "ARNs de usuarios que pueden administrar claves KMS"
  type        = list(string)
}

variable "kms_key_users" {
  description = "ARNs de usuarios que pueden usar claves KMS"
  type        = list(string)
}

variable "eks_cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  type        = string
  default     = ""
}

variable "eks_cluster_ca_cert" {
  description = "Certificado CA del cluster EKS (base64)"
  type        = string
  default     = ""
}

variable "eks_cluster_token" {
  description = "Token de acceso al cluster EKS"
  type        = string
  default     = ""
  sensitive   = true
}

variable "enable_waf" {
  description = "Habilitar AWS WAF para protección de aplicaciones"
  type        = bool
  default     = false
}

variable "cloudwatch_log_retention_days" {
  description = "Días de retención para logs de CloudWatch"
  type        = number
  default     = 90
  validation {
    condition     = var.cloudwatch_log_retention_days >= 1 && var.cloudwatch_log_retention_days <= 365
    error_message = "Los días de retención deben estar entre 1 y 365"
  }
}

variable "enable_guardduty" {
  description = "Habilitar Amazon GuardDuty para detección de amenazas"
  type        = bool
  default     = false
}

variable "rto_minutes" {
  description = "Recovery Time Objective en minutos"
  type        = number
  default     = 60
}

variable "rpo_minutes" {
  description = "Recovery Point Objective en minutos"
  type        = number
  default     = 15
}

// === ARCHIVO: main.tf ===
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

// === ARCHIVO: outputs.tf ===
# =============================================================================
# OUTPUTS DE VPC - Identificadores y configuración de la red virtual
# =============================================================================
output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC principal"
  value       = aws_vpc.main.cidr_block
}

output "vpc_dns_hostnames_enabled" {
  description = "Indicador de DNS hostnames habilitado"
  value       = aws_vpc.main.enable_dns_hostnames
}

output "vpc_dns_support_enabled" {
  description = "Indicador de DNS support habilitado"
  value       = aws_vpc.main.enable_dns_support
}

# =============================================================================
# OUTPUTS DE SUBREDES PÚBLICAS
# =============================================================================
output "subnet_public_payments_id" {
  description = "ID de subred pública de pagos AZ1"
  value       = aws_subnet.public_payments.id
}

output "subnet_public_payments_az2_id" {
  description = "ID de subred pública de pagos AZ2"
  value       = aws_subnet.public_payments_az2.id
}

output "subnet_public_monitoring_id" {
  description = "ID de subred pública de monitoreo AZ1"
  value       = aws_subnet.public_monitoring.id
}

output "subnet_public_monitoring_az2_id" {
  description = "ID de subred pública de monitoreo AZ2"
  value       = aws_subnet.public_monitoring_az2.id
}

output "public_subnet_ids" {
  description = "Lista de IDs de todas las subredes públicas"
  value       = [aws_subnet.public_payments.id, aws_subnet.public_payments_az2.id, aws_subnet.public_monitoring.id, aws_subnet.public_monitoring_az2.id]
}

output "public_subnets_cidrs" {
  description = "Lista de bloques CIDR de todas las subredes públicas"
  value       = [var.subnet_public_payments_cidr, var.subnet_public_payments_cidr_az2, var.subnet_public_monitoring_cidr, var.subnet_public_monitoring_cidr_az2]
}

# =============================================================================
# OUTPUTS DE SUBREDES PRIVADAS
# =============================================================================
output "subnet_private_payments_id" {
  description = "ID de subred privada de pagos AZ1"
  value       = aws_subnet.private_payments.id
}

output "subnet_private_payments_az2_id" {
  description = "ID de subred privada de pagos AZ2"
  value       = aws_subnet.private_payments_az2.id
}

output "subnet_private_database_id" {
  description = "ID de subred privada de base de datos AZ1"
  value       = aws_subnet.private_database.id
}

output "subnet_private_database_az2_id" {
  description = "ID de subred privada de base de datos AZ2"
  value       = aws_subnet.private_database_az2.id
}

output "subnet_private_audit_id" {
  description = "ID de subred privada de auditoría AZ1"
  value       = aws_subnet.private_audit.id
}

output "subnet_private_audit_az2_id" {
  description = "ID de subred privada de auditoría AZ2"
  value       = aws_subnet.private_audit_az2.id
}

output "private_subnet_ids" {
  description = "Lista de IDs de todas las subredes privadas"
  value       = [aws_subnet.private_payments.id, aws_subnet.private_payments_az2.id, aws_subnet.private_database.id, aws_subnet.private_database_az2.id, aws_subnet.private_audit.id, aws_subnet.private_audit_az2.id]
}

output "private_subnets_cidrs" {
  description = "Lista de bloques CIDR de todas las subredes privadas"
  value       = [var.subnet_private_payments_cidr, var.subnet_private_payments_cidr_az2, var.subnet_private_database_cidr, var.subnet_private_database_cidr_az2, var.subnet_private_audit_cidr, var.subnet_private_audit_cidr_az2]
}

# =============================================================================
# OUTPUTS DE GATEWAYS
# =============================================================================
output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_az1_id" {
  description = "ID del NAT Gateway AZ1"
  value       = aws_nat_gateway.main_az1.id
}

output "nat_gateway_az2_id" {
  description = "ID del NAT Gateway AZ2"
  value       = aws_nat_gateway.main_az2.id
}

output "nat_gateway_az1_ip" {
  description = "IP elástica del NAT Gateway AZ1"
  value       = aws_eip.nat_eip_az1.public_ip
}

output "nat_gateway_az2_ip" {
  description = "IP elástica del NAT Gateway AZ2"
  value       = aws_eip.nat_eip_az2.public_ip
}

output "nat_gateway_ids" {
  description = "Lista de IDs de todos los NAT Gateways"
  value       = [aws_nat_gateway.main_az1.id, aws_nat_gateway.main_az2.id]
}

# =============================================================================
# OUTPUTS DE TABLAS DE RUTAS
# =============================================================================
output "route_table_public_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "route_table_private_az1_id" {
  description = "ID de la tabla de rutas privada AZ1"
  value       = aws_route_table.private_az1.id
}

output "route_table_private_az2_id" {
  description = "ID de la tabla de rutas privada AZ2"
  value       = aws_route_table.private_az2.id
}

output "all_route_table_ids" {
  description = "Lista de IDs de todas las tablas de rutas"
  value       = [aws_route_table.public.id, aws_route_table.private_az1.id, aws_route_table.private_az2.id]
}

# =============================================================================
# OUTPUTS DE ARQUITECTURA - Para integración con otros módulos
# =============================================================================
output "availability_zones" {
  description = "Lista de AZs disponibles utilizadas"
  value       = data.aws_availability_zones.available.names
}

output "network_architecture" {
  description = "Descripción de la arquitectura de red"
  value = {
    vpc_cidr               = aws_vpc.main.cidr_block
    public_subnets         = "4 subredes públicas en 2 AZs (pagos y monitoreo)"
    private_subnets        = "6 subredes privadas en 2 AZs (pagos, database, audit)"
    internet_gateway       = "1 IGW para acceso público"
    nat_gateways           = "2 NAT Gateways (uno por AZ) para salida privada"
    high_availability      = "Despliegue multi-AZ para tolerancia a fallos"
    isolation_level        = "Segmentación completa entre tiers públicos y privados"
    payment_services_subnets = [aws_subnet.private_payments.id, aws_subnet.private_payments_az2.id]
    database_subnets       = [aws_subnet.private_database.id, aws_subnet.private_database_az2.id]
    audit_subnets          = [aws_subnet.private_audit.id, aws_subnet.private_audit_az2.id]
  }
}

// === ARCHIVO: backend.tf ===
# =============================================================================
# CONFIGURACIÓN DEL BACKEND REMOTO
# Almacena el estado de Terraform en S3 con bloqueo en DynamoDB
# =============================================================================
terraform {
  backend "s3" {
    bucket         = "${var.project_name}-terraform-state-${var.environment}"
    key            = "${var.environment}/network/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "${var.project_name}-terraform-locks"

    # Configuración de versioning del bucket de estado
    versioning = true

    # Prevent accidental deletion of state
    skip_bucket_versioning = false
  }
}

# =============================================================================
# RECURSOS DE INFRAESTRUCTURA PARA EL BACKEND
# Estos recursos deben existir antes de usar el backend remoto
# =============================================================================

# Bucket S3 para almacenar el estado de Terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-terraform-state-${var.environment}"

  tags = {
    Name        = "${var.project_name}-terraform-state-${var.environment}"
    Description = "Bucket para almacenar estado de Terraform"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Versioning del bucket de estado
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Bloqueo público al bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Servidor de encriptación del bucket con KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Tabla DynamoDB para bloqueo de estado
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.project_name}-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.project_name}-terraform-locks"
    Description = "Tabla para bloqueo de estado de Terraform"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Política de acceso a la tabla de bloqueo
resource "aws_dynamodb_table_policy" "terraform_locks_policy" {
  name = "${var.project_name}-terraform-locks-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowTerraformLocking"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Resource = aws_dynamodb_table.terraform_locks.arn
        Condition = {
          Bool = {
            "aws:SecureTransport" = "true"
          }
        }
      }
    ]
  })
}

# =============================================================================
# LLAVE KMS PARA CIFRADO DEL ESTADO
# Cifrado en reposo para el bucket S3 y tabla DynamoDB
# =============================================================================
resource "aws_kms_key" "terraform_state" {
  description             = "Llave KMS para cifrado del estado de Terraform"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "terraform-state-key-policy"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow S3 to use this key"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          }
        }
      },
      {
        Sid    = "Allow DynamoDB to use this key"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          }
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-kms-terraform-state"
    Description = "Llave KMS para cifrado del estado de Terraform"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Alias de la llave KMS
resource "aws_kms_alias" "terraform_state" {
  name          = "alias/${var.project_name}-terraform-state"
  target_key_id = aws_kms_key.terraform_state.key_id
}


// === ARCHIVO: README.md ===
# Infraestructura de Red Segura para Entorno de Pagos

## Descripción del Proyecto

Este proyecto implementa una topología de red segura en AWS diseñada específicamente para un entorno de procesamiento de pagos que debe manejar 10,000 transacciones por segundo con un SLA de 99.9%. La arquitectura sigue el patrón de arquitectura de red de tres capas con segmentación estricta entre servicios de pago, monitoreo y auditoría.

La infraestructura se construye utilizando Terraform en su versión 1.7.5 con el provider AWS 5.0, siguiendo principios de infraestructura como código reproducible, versionable y auditables. El diseño cumple con los requisitos de confidencialidad, integridad y disponibilidad establecidos para sistemas de pago PCI-DSS compatibles.

## Arquitectura de la Solución

### Topología de Red

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              VPC Principal (10.0.0.0/16)                        │
│                                                                                  │
│  ┌──────────────────────────────────────────────────────────────────────────┐  │
│  │                        Zona de Disponibilidad A                         │  │
│  │                                                                           │  │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                     │  │
│  │  │  Subred Pública     │    │  Subred Privada     │                     │  │
│  │  │  (App Tier)         │    │  (Datos Pagos)      │                     │  │
│  │  │  10.0.1.0/24        │    │  10.0.11.0/24       │                     │  │
│  │  │                     │    │                     │                     │  │
│  │  │  • ALB              │    │  • RDS Pagos        │                     │  │
│  │  │  • NAT Gateway      │    │  • Lambda Pagos     │                     │  │
│  │  │  • Bastion Host     │    │  • DynamoDB         │                     │  │
│  │  └─────────────────────┘    └─────────────────────┘                     │  │
│  │                                                                           │  │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                     │  │
│  │  │  Subred Pública     │    │  Subred Privada     │                     │  │
│  │  │  (Monitoreo)        │    │  (Auditoría)        │                     │  │
│  │  │  10.0.2.0/24        │    │  10.0.12.0/24       │                     │  │
│  │  │                     │    │                     │                     │  │
│  │  │  • CloudWatch       │    │  • Logs Auditoría   │                     │  │
│  │  │  • Prometheus       │    │  • S3 Auditoría     │                     │  │
│  │  │  • Grafana          │    │  • KMS Keys         │                     │  │
│  │  └─────────────────────┘    └─────────────────────┘                     │  │
│  └──────────────────────────────────────────────────────────────────────────┘  │
│                                                                                  │
│  ┌──────────────────────────────────────────────────────────────────────────┐  │
│  │                        Zona de Disponibilidad B                         │  │
│  │                                                                           │  │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                     │  │
│  │  │  Subred Pública     │    │  Subred Privada     │                     │  │
│  │  │  (App Tier)         │    │  (Datos Pagos)      │                     │  │
│  │  │  10.0.101.0/24      │    │  10.0.111.0/24      │                     │  │
│  │  │                     │    │                     │                     │  │
│  │  │  • ALB (secundario) │    │  • RDS Replica      │                     │  │
│  │  │  • NAT Gateway      │    │  • Lambda Pagos     │                     │  │
│  │  └─────────────────────┘    └─────────────────────┘                     │  │
│  │                                                                           │  │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                     │  │
│  │  │  Subred Pública     │    │  Subred Privada     │                     │  │
│  │  │  (Monitoreo)        │    │  (Auditoría)        │                     │  │
│  │  │  10.0.102.0/24      │    │  10.0.112.0/24      │                     │  │
│  │  │                     │    │                     │                     │  │
│  │  │  • Monitoring Agent │    │  • Logs Replica     │                     │  │
│  │  │  • Backup Storage   │    │  • Glacier Vault    │                     │  │
│  │  └─────────────────────┘    └─────────────────────┘                     │  │
│  └──────────────────────────────────────────────────────────────────────────┘  │
│                                                                                  │
│  ┌──────────────────────────────────────────────────────────────────────────┐  │
│  │                        Internet Gateway                                  │  │
│  │                        igw-xxxxxxxx                                      │  │
│  └──────────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Segmentación de Red por Propósito

La arquitectura define cuatro segmentos de red claramente diferenciados que garantizan el aislamiento lógico requerido para un entorno de pagos. Cada segmento tiene un propósito específico y políticas de seguridad adaptadas a su función dentro del ecosistema de procesamiento de transacciones.

El primer segmento corresponde a las subredes públicas de aplicación, identificadas con el rango CIDR 10.0.1.0/24 y 10.0.101.0/24 en las zonas de disponibilidad A y B respectivamente. Estas subredes albergan los componentes que requieren exposición a internet, específicamente el Application Load Balancer que recibe las transacciones entrantes y los NAT Gateways que permiten a los servicios en subredes privadas establecer conexiones salientes hacia internet para actualizaciones y comunicaciones con APIs externas. La regla de seguridad aplicada permite tráfico entrante solo hacia el ALB en el puerto 443, y tráfico saliente hacia internet únicamente a través de los NAT Gateway con filtering de destinos permitidos.

El segundo segmento comprende las subredes privadas de procesamiento de pagos, con rangos 10.0.11.0/24 y 10.0.111.0/24. Aquí se ejecutan los componentes críticos del motor de pagos incluyendo la base de datos RDS PostgreSQL con cifrado KMS, las funciones Lambda que procesan la lógica de negocio deloriginador de pagos y el motor antifraude, y las tablas de DynamoDB para el almacenamiento de estados de transacción. Esta es la zona más restrictiva: no tiene acceso directo a internet y todas las comunicaciones hacia ella deben pasar por el ALB o mediante AWS PrivateLink desde servicios autorizados.

El tercer segmento corresponde a las subredes de monitoreo público con CIDR 10.0.2.0/24 y 10.0.102.0/24. En estas subredes se despliegan las herramientas de observabilidad como CloudWatch Agents, Prometheus para recolección de métricas y Grafana para visualización. La exposición pública permite que los equipos de operaciones accedan a los dashboards de monitoreo sin necesidad de conectividad VPN a la VPC, aunque autenticación robusta mediante IAM y OAuth está enforced.

El cuarto segmento es el de auditoría privada con rangos 10.0.12.0/24 y 10.0.112.0/24. Aquí se almacenan los logs de auditoría en S3 con versioning habilitado, los AWS KMS keys para gestión de claves de cifrado, y los buckets de Glacier para retención a largo plazo de registros de auditoría. El acceso es estrictamente controlado mediante políticas IAM específicas y todo acceso queda registrado en CloudTrail.

## Estructura de Módulos

### Módulo de Red (modules/network)

El módulo de red constituye la base de toda la infraestructura y se compone de cinco recursos fundamentales que crean la topología de conectividad de la VPC.

El archivo vpc.tf define la Virtual Private Cloud con el bloque CIDR 10.0.0.0/16 que proporciona espacio suficiente para los cuatro segmentos de red más capacidad de crecimiento futuro. La VPC se configura con DNS hosting y DNS support habilitados, junto con las opciones de enableNetworkAddressUsageMetrics para optimización de costos. El recurso incluye tags obligatorios que permiten identificar el entorno, el costo y el propósito de cada recurso.

El archivo subnets.tf crea las ocho subredes necesarias distribuidas en dos zonas de disponibilidad para garantizar la alta disponibilidad requerida del 99.9%. Cada par de subredes (pública, privada de pagos, pública de monitoreo, privada de auditoría) se crea en cada zona con sus correspondientes tags de identificación de propósito y zona. Las subredes privadas se configuran con el atributo map_public_ip_on_launch en false para garantizar que los recursos que se desplieguen en ellas no tengan direcciones IP públicas.

El archivo internet_gateway.tf establece el punto de conexión entre la VPC e internet. El Internet Gateway se adjunta a la VPC y permite el tráfico bidireccional entre las subredes públicas e internet. Se configura con las tags estándar de identificación del entorno.

El archivo nat_gateway.tf despliega un NAT Gateway en cada zona de disponibilidad para proporcionar conectividad saliente a internet a los recursos en subredes privadas. Cada NAT Gateway se despliega en una subred pública específica y se asocia a una Elastic IP. La arquitectura con NAT Gateways distribuidos garantiza que si una zona de disponibilidad falla, las instancias en la otra zona mantengan conectividad a internet.

El archivo route_tables.tf define las tablas de rutas que controlan el flujo de tráfico dentro de la VPC. La tabla de rutas pública tiene una ruta default hacia el Internet Gateway, mientras que cada tabla de rutas privada tiene una ruta default hacia el NAT Gateway de su zona de disponibilidad correspondiente. Esta distribución de rutas por zona optimiza la latencia y garantiza la alta disponibilidad.

### Módulo de Seguridad (modules/security)

El módulo de seguridad implementa las capas de protección requeridas para un entorno de pagos, aplicando el principio de menor privilegio en cada componente.

El archivo security_groups.tf define los grupos de seguridad que controlan el tráfico a nivel de instancia y aplicación. Se crean grupos específicos para el ALB que permite tráfico HTTPS entrante desde cualquier origen y tráfico hacia las subredes privadas de aplicación. El grupo de seguridad de RDS permite conexiones desde el grupo de seguridad de la capa de aplicación únicamente en el puerto 5432. El grupo de seguridad de Lambda permite tráfico entrante desde el ALB y desde otras Lambdas del entorno de pagos. Los grupos de seguridad de monitoreo permiten tráfico entrante desde las redes de operaciones y desde las subredes de procesamiento de pagos.

El archivo iam.tf contiene las políticas IAM que definen los permisos mínimos necesarios para cada componente del sistema. La política del rol de Lambda de pagos incluye permisos específicos para acceder a DynamoDB, KMS para cifrado, y S3 para logs, sin permisos generales que excedan lo necesario. El rol de ejecución de Lambda tiene la política AmazonLambdaVPCAccessExecutionRole adjunta para permitir la escritura en CloudWatch Logs. Las políticas de acceso a datos siguen el principio de menor privilegio: solo permiten las operaciones específicas sobre los recursos específicos requeridos por cada componente.

El archivo kms.tf gestiona las claves de KMS para el cifrado en reposo de todos los recursos sensibles. Se crea una clave maestra por entorno con políticas que restringen el uso a roles IAM específicos del entorno. Las claves de cifrado de RDS utilizan esta clave maestra para el cifrado de la base de datos. Las claves de S3 utilizan la misma estrategia para los buckets de logs y auditoría. La política de claves incluye rotación automática anual y restricciones geográficas para el uso de las claves.

### Módulo de Servicios (modules/services)

El módulo de servicios despliega los componentes de aplicación que operan sobre la infraestructura de red y seguridad.

El archivo rds.tf configura la base de datos PostgreSQL del sistema de pagos. La instancia se despliega en múltiples zonas de disponibilidad con una réplica de lectura en la segunda zona. El almacenamiento utiliza IOPS provisionadas para soportar el throughput de 10,000 transacciones por segundo. El cifrado en reposo está habilitado utilizando la clave KMS del entorno. Los parámetros de base de datos se configuran para PCI-DSS compliance incluyendo logging de todas las consultas y conexiones.

El archivo lambda.tf define las funciones Lambda que ejecutan la lógica de procesamiento de pagos. Se configuran dos funciones: una para el procesamiento principal de transacciones y otra para el motor antifraude. Ambas funciones se despliegan en las subredes privadas de pagos con acceso a la base de datos y a los servicios de KMS. La configuración incluye reserved concurrency para garantizar capacidad y dead letter queues para manejo de fallos.

El archivo alb.tf crea el Application Load Balancer que recibe el tráfico de pagos en las subredes públicas. El ALB está configurado con HTTPS obligatorio utilizando certificados ACM. Se configuran health checks hacia las funciones Lambda y target groups con el tipo lambda. El ALB implementa protección mediante AWS WAF reglas específicas para mitigar ataques comunes a aplicaciones web.

## Configuración por Ambiente

La infraestructura soporta tres ambientes diferenciados que permiten el ciclo de desarrollo, pruebas y producción con aislamiento adecuado.

### Desarrollo (environments/dev)

El ambiente de desarrollo utiliza recursos de menor tamaño para optimización de costos mientras mantiene la misma topología de red. La base de datos RDS utiliza una instancia db.t3.medium con almacenamiento de 100 GB. Las funciones Lambda tienen un límite de concurrency de 10. El backend de Terraform utiliza el bucket de estados de desarrollo con versioning habilitado. Las variables específicas del ambiente se encuentran en environments/dev/terraform.tfvars.

### Calidad (environments/qa)

El ambiente de QA replica la configuración de producción en términos de arquitectura pero con recursos dimensionados para cargas de prueba. La base de datos utiliza instancias db.r5.large para manejar las pruebas de carga de hasta 10,000 TPS. El ambiente tiene acceso a los mismos servicios de monitoreo que producción pero con retención de logs reducida. La configuración se encuentra en environments/qa/terraform.tfvars.

### Producción (environments/prod)

El ambiente de producción implementa la configuración completa con todos los componentes de alta disponibilidad. La base de datos utiliza instancias db.r5.xlarge en configuración Multi-AZ con lectura replicada. Las funciones Lambda tienen concurrency reservada de 100 para garantizar capacidad bajo carga pico. El entorno incluye todas las integraciones de auditoría y monitoreo. La configuración se encuentra en environments/prod/terraform.tfvars.

## Comandos de Despliegue

El despliegue de la infraestructura sigue un proceso secuencial que garantiza la consistencia del estado de Terraform y la trazabilidad de los cambios realizados en cada ambiente.

### Inicialización del Entorno

El primer paso consiste en inicializar Terraform con el backend configurado para almacenar el estado en S3 con bloqueo mediante DynamoDB. Este comando descarga los providers necesarios y configura el backend remoto.

```bash
cd environments/{dev|qa|prod}
terraform init -backend-config=backend.hcl
```

### Validación de la Configuración

Antes de planificar o aplicar cambios, es fundamental validar que la configuración de Terraform no contiene errores de sintaxis o referencias inválidas. El comando validate verifica la consistencia de los archivos de configuración.

```bash
terraform validate
```

### Verificación de Formato

El comando fmt verifica que los archivos de configuración siguen el formato estándar de Terraform. Se recomienda ejecutar este comando antes de cada commit para mantener la consistencia del código.

```bash
terraform fmt -check -recursive
```

### Planificación de Cambios

El comando plan genera un plan de ejecución que muestra los recursos que se crearán, modificarán o destruirán. Este paso es obligatorio antes de aplicar cambios en cualquier ambiente y debe ser revisado por un aprobador.

```bash
terraform plan -var-file=terraform.tfvars -out=tfplan
```

### Aplicación de Cambios

El comando apply despliega los recursos definidos en el plan. En entornos de producción se recomienda revisar el plan generado antes de confirmar la aplicación.

```bash
terraform apply tfplan
```

### Destrucción de Recursos

Para eliminar todos los recursos creados por Terraform se utiliza el comando destroy. Este comando debe ejecutarse con extrema precaución en entornos de producción.

```bash
terraform destroy -var-file=terraform.tfvars
```

## Diagrama de Flujo de Transacciones

El siguiente diagrama ilustra el flujo de una transacción de pago a través de la infraestructura de red segura:

```
┌──────────────┐     HTTPS      ┌──────────────┐
│  Cliente     │───────────────>│     ALB      │
│  Pagos       │   (443/tls)    │  (WAF + DDoS)│
└──────────────┘                └──────┬───────┘
                                        │
                                        │ HTTP
                                        ▼
                               ┌────────────────┐
                               │   Lambda       │
                               │  Procesador    │
                               │   Pagos        │
                               └───────┬────────┘
                                       │
                    ┌──────────────────┼──────────────────┐
                    │                  │                  │
                    ▼                  ▼                  ▼
           ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
           │     RDS      │   │  DynamoDB    │   │    Lambda    │
           │  PostgreSQL  │   │  Transacciones│   │  Anti-Fraude │
           │ (Cifrado)    │   │ (Cifrado)    │   │              │
           └──────────────┘   └──────────────┘   └──────────────┘
                    │                  │                  │
                    └──────────────────┼──────────────────┘
                                       │
                                       ▼
                               ┌────────────────┐
                               │      S3        │
                               │   Auditoría    │
                               │  (Logs + KMS)  │
                               └────────────────┘
```

El flujo inicia cuando un cliente envía una solicitud de pago al Application Load Balador a través de HTTPS. El ALB, protegido por WAF contra ataques comunes y por AWS Shield contra DDoS, terminates la conexión TLS y reenvía la solicitud a la función Lambda de procesamiento de pagos desplegada en las subredes privadas.

La función Lambda procesa la transacción validando los datos del pago y consultando el motor antifraude, también desplegado como Lambda en las subredes privadas. El resultado de la evaluación antifraude se almacena en DynamoDB con cifrado KMS para su trazabilidad.

Los datos persistentes de la transacción se almacenan en RDS PostgreSQL con cifrado en reposo utilizando la clave KMS del entorno. La base de datos opera en configuración Multi-AZ para garantizar la disponibilidad requerida del 99.9%.

Finalmente, todos los eventos de la transacción se registran en S3 para auditoría, incluyendo logs de CloudWatch que permiten reconstruir el historial completo de cada transacción. Los logs se cifran con KMS y se retentionan según las políticas de cumplimiento PCI-DSS.

## Requisitos de Cumplimiento

La arquitectura implementada está diseñada para cumplir con los requisitos de PCI-DSS nivel 1, que es el nivel más estricto de cumplimiento para procesadores de pagos. A continuación se describen los controles implementados para los requisitos clave del estándar.

El requisito 3 de PCI-DSS regarding la protección de datos de holders de tarjetas se satisface mediante el cifrado en reposo de todas las bases de datos y buckets de almacenamiento utilizando claves KMS dedicadas. Las claves tienen rotación anual automática y las políticas de acceso restrictivas garantizan que solo los componentes autorizados pueden descifrar los datos.

El requisito 4 relacionado con la transmisión de datos de holders de tarjetas a través de redes abiertas se cumple utilizando TLS 1.3 para todas las comunicaciones, con certificados gestionados por AWS Certificate Manager. El ALB está configurado para rechazar cualquier conexión que no utilice cifrado válido.

El requisito 7 sobre la restricción del acceso a los datos de holders de tarjetas por necesidad de conocer se implementa mediante políticas IAM con el principio de menor privilegio. Cada componente tiene únicamente los permisos necesarios para realizar su función específica, sin permisos generales ni acceso a datos que no requiera para su operación.

El requisito 10 relacionado con el registro y monitoreo de todos los accesos a los componentes del sistema y los datos de holders de tarjetas se satisface mediante la integración completa con CloudTrail para eventos de gestión, CloudWatch Logs para logs de aplicación, y S3 con versioning para logs de auditoría inmutables.

## Consideraciones de Costos

La infraestructura implementa varias prácticas de optimización de costos que deben considerarse al operar el entorno.

El etiquetado obligatorio de todos los recursos mediante las tags Name, Environment y CostCenter permite el análisis detallado de costos por servicio y entorno. Los reportes de costos de AWS se pueden filtrar por estas etiquetas para identificar oportunidades de optimización.

El uso de NAT Gateways por zona de disponibilidad implica costos por hora de uso y por datos procesados. La arquitectura propuesta optimiza este costo al enrutar el tráfico de salida por el NAT Gateway de la misma zona donde se origina la solicitud, minimizando los costos de transferencia entre zonas.

Los buckets de S3 para auditoría utilizan políticas de lifecycle para mover objetos antiguos a clases de almacenamiento más económicas. Los logs de CloudWatch se configuran con retención optimizada por tipo de logs: métricas de alta resolución con retención de 15 días, mientras que los logs de auditoría se retentionan en CloudWatch por 90 días antes de archivarlos en S3 Glacier.

## Mantenimiento y Operaciones

### Actualización de la Infraestructura

Las actualizaciones de la infraestructura se realizan siguiendo el proceso de GitOps implementado. Los cambios se proponen mediante Pull Requests que incluyen el plan de Terraform generado automáticamente por el pipeline de CI/CD. После одобрения и мерджa, pipeline применяет изменения автоматически.

### Monitoreo y Alertas

El sistema implementa monitoreo continuo mediante CloudWatch Dashboards que muestran métricas clave de la infraestructura: latencia del ALB, errores de Lambda, uso de conexiones RDS, y métricas de NAT Gateway. Las alertas de CloudWatch se configuran para notificar al equipo de operaciones cuando las métricas superan los umbrales definidos.

### Recuperación ante Desastres

La arquitectura implementsa un RTO (Recovery Time Objective) de 15 minutos y un RPO (Recovery Point Objective) de 1 minuto para el sistema de pagos. Esto se logra mediante la replicación Multi-AZ de RDS, la distribución de Lambda functions en múltiples zonas de disponibilidad, y backups automáticos de DynamoDB con point-in-time recovery habilitado. El plan de recuperación ante desastres se documenta por separado y se prueba trimestralmente.


// === ARCHIVO: modules/network/vpc.tf ===
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-vpc-${var.environment}"
      Purpose     = "Infraestructura principal de red"
      Layer       = "network"
      ManagedBy   = "terraform"
    }
  )
}

resource "aws_default_security_group" "vpc_default" {
  vpc_id = aws_vpc.main.id

  ingress = []
  egress  = []

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-default-sg-${var.environment}"
      Description = "Security group por defecto - restringir todo tráfico"
    }
  )
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = concat(
    [aws_route_table.public.id],
    [aws_route_table.private.id]
  )

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-s3-endpoint-${var.environment}"
      Purpose    = "Acceso privado a S3 sin tráfico por internet"
    }
  )
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.dynamodb"
  route_table_ids = concat(
    [aws_route_table.public.id],
    [aws_route_table.private.id]
  )

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-dynamodb-endpoint-${var.environment}"
      Purpose    = "Acceso privado a DynamoDB sin tráfico por internet"
    }
  )
}

resource "aws_vpc_endpoint" "secrets_manager_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.secretsmanager"
  route_table_ids = [aws_route_table.private.id]

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-secrets-manager-endpoint-${var.environment}"
      Purpose    = "Acceso privado a Secrets Manager desde subredes privadas"
    }
  )
}

resource "aws_vpc_endpoint" "ssm_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.ssm"
  route_table_ids = [aws_route_table.private.id]

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-ssm-endpoint-${var.environment}"
      Purpose    = "Acceso privado a SSM para gestión de instancias"
    }
  )
}

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "default_security_group_id" {
  description = "ID del security group por defecto de la VPC"
  value       = aws_default_security_group.vpc_default.id
}

// === ARCHIVO: modules/network/subnets.tf ===
locals {
  availability_zones = var.availability_zones
  
  subnets_public = {
    "public_monitoreo_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 0)
      availability_zone = local.availability_zones[0]
      purpose           = "monitoreo"
      type              = "public"
    }
    "public_monitoreo_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 1)
      availability_zone = local.availability_zones[1]
      purpose           = "monitoreo"
      type              = "public"
    }
    "public_auditoria_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 2)
      availability_zone = local.availability_zones[0]
      purpose           = "auditoria"
      type              = "public"
    }
    "public_auditoria_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 3)
      availability_zone = local.availability_zones[1]
      purpose           = "auditoria"
      type              = "public"
    }
  }
  
  subnets_private = {
    "private_pagos_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 4)
      availability_zone = local.availability_zones[0]
      purpose           = "pagos"
      type              = "private"
    }
    "private_pagos_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 5)
      availability_zone = local.availability_zones[1]
      purpose           = "pagos"
      type              = "private"
    }
    "private_pagos_db_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 6)
      availability_zone = local.availability_zones[0]
      purpose           = "pagos"
      type              = "private"
      database          = true
    }
    "private_pagos_db_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 7)
      availability_zone = local.availability_zones[1]
      purpose           = "pagos"
      type              = "private"
      database          = true
    }
    "private_monitoreo_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 8)
      availability_zone = local.availability_zones[0]
      purpose           = "monitoreo"
      type              = "private"
    }
    "private_monitoreo_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 9)
      availability_zone = local.availability_zones[1]
      purpose           = "monitoreo"
      type              = "private"
    }
    "private_auditoria_a" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 10)
      availability_zone = local.availability_zones[0]
      purpose           = "auditoria"
      type              = "private"
    }
    "private_auditoria_b" = {
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, 11)
      availability_zone = local.availability_zones[1]
      purpose           = "auditoria"
      type              = "private"
    }
  }
  
  all_subnets = merge(local.subnets_public, local.subnets_private)
}

resource "aws_subnet" "main" {
  for_each = local.all_subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.type == "public"

  tags = merge(
    var.common_tags,
    {
      Name               = "${var.project_name}-${each.key}-${var.environment}"
      Purpose            = each.value.purpose
      Type               = each.value.type
      Layer              = "network"
      AvailabilityZone   = each.value.availability_zone
      CostCenter         = var.cost_center
      Environment        = var.environment
      "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
    }
  )
}

resource "aws_subnet_group" "pagos" {
  name = "${var.project_name}-pagos-subnet-group-${var.environment}"
  
  subnet_ids = [for k, v in aws_subnet.main : aws_subnet.main[k].id if v.tags.Purpose == "pagos"]
  
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-pagos-subnet-group-${var.environment}"
      Description = "Grupo de subredes para servicios de pagos"
    }
  )
}

resource "aws_subnet_group" "monitoreo" {
  name = "${var.project_name}-monitoreo-subnet-group-${var.environment}"
  
  subnet_ids = [for k, v in aws_subnet.main : aws_subnet.main[k].id if v.tags.Purpose == "monitoreo"]
  
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-monitoreo-subnet-group-${var.environment}"
      Description = "Grupo de subredes para servicios de monitoreo"
    }
  )
}

resource "aws_subnet_group" "auditoria" {
  name = "${var.project_name}-auditoria-subnet-group-${var.environment}"
  
  subnet_ids = [for k, v in aws_subnet.main : aws_subnet.main[k].id if v.tags.Purpose == "auditoria"]
  
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-auditoria-subnet-group-${var.environment}"
      Description = "Grupo de subredes para servicios de auditoría"
    }
  )
}

output "subnet_ids" {
  description = "Mapeo de IDs de subredes por nombre"
  value       = { for k, v in aws_subnet.main : k => v.id }
}

output "public_subnet_ids" {
  description = "IDs de subredes públicas"
  value       = [for k, v in aws_subnet.main : v.id if v.tags.Type == "public"]
}

output "private_subnet_ids" {
  description = "IDs de subredes privadas"
  value       = [for k, v in aws_subnet.main : v.id if v.tags.Type == "private"]
}

output "pagos_subnet_ids" {
  description = "IDs de subredes de pagos"
  value       = [for k, v in aws_subnet.main : v.id if v.tags.Purpose == "pagos"]
}

// === ARCHIVO: modules/network/route_tables.tf ===
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-public-rt-${var.environment}"
      Description = "Tabla de rutas para subredes públicas - acceso a internet via IGW"
      Type        = "public"
      Layer       = "network"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  route {
    cidr_block                = "10.0.0.0/8"
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-private-rt-${var.environment}"
      Description = "Tabla de rutas para subredes privadas - acceso a internet via NAT Gateway"
      Type        = "private"
      Layer       = "network"
    }
  )
}

resource "aws_route_table" "pagos" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  route {
    cidr_block                = "10.0.0.0/8"
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-pagos-rt-${var.environment}"
      Description = "Tabla de rutas dedicada para subredes de pagos"
      Purpose     = "pagos"
      Type        = "private"
      Layer       = "network"
    }
  )
}

resource "aws_route_table_association" "public" {
  for_each = toset(var.public_subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = toset([for s in var.private_subnet_ids : s if s != var.pagos_db_subnet_ids[0] && s != var.pagos_db_subnet_ids[1]])

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "pagos" {
  for_each = toset([for s in var.private_subnet_ids : s if s == var.pagos_db_subnet_ids[0] || s == var.pagos_db_subnet_ids[1]])

  subnet_id      = each.value
  route_table_id = aws_route_table.pagos.id
}

resource "aws_route" "vpn_to_onpremises" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = var.onpremises_cidr
  gateway_id = var.vpn_gateway_id
}

resource "aws_route" "s3_via_endpoint" {
  route_table_id = aws_route_table.private.id
  destination_prefix_list_id = "pl-63a5400a"
  vpc_endpoint_id = var.s3_endpoint_id
}

resource "aws_route" "dynamodb_via_endpoint" {
  route_table_id = aws_route_table.private.id
  destination_prefix_list_id = "pl-63a6400b"
  vpc_endpoint_id = var.dynamodb_endpoint_id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID de la tabla de rutas privada"
  value       = aws_route_table.private.id
}

output "pagos_route_table_id" {
  description = "ID de la tabla de rutas de pagos"
  value       = aws_route_table.pagos.id
}


// === ARCHIVO: modules/network/internet_gateway.tf ===
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-igw"
      Description = "Internet Gateway para subredes públicas del entorno de pagos"
      Component   = "Network"
      Layer       = "Public"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ec2_tag" "igw_cost_tag" {
  resource_id = aws_internet_gateway.main.id
  key         = "CostCenter"
  value       = var.cost_center
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "internet_gateway_arn" {
  description = "ARN del Internet Gateway"
  value       = aws_internet_gateway.main.arn
}

// === ARCHIVO: modules/network/nat_gateway.tf ===
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-nat-eip"
      Description = "Elastic IP para NAT Gateway"
      Component   = "Network"
      Layer       = "Public"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.environment}-nat-gw"
      Description = "NAT Gateway para acceso a internet desde subredes privadas"
      Component   = "Network"
      Layer       = "Private"
      Purpose     = "Egress-to-Internet"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ec2_tag" "nat_cost_tag" {
  resource_id = aws_nat_gateway.main.id
  key         = "CostCenter"
  value       = var.cost_center
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "nat_gateway_arn" {
  description = "ARN del NAT Gateway"
  value       = aws_nat_gateway.main.arn
}

output "nat_eip_allocation_id" {
  description = "Allocation ID de la EIP asociada al NAT Gateway"
  value       = aws_eip.nat.id
}

// === ARCHIVO: modules/security/security_groups.tf ===
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


// === ARCHIVO: modules/security/iam.tf ===
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  tags = merge(var.common_tags, { Name = "lambda-execution-role-${var.environment}" })
}

resource "aws_iam_role_policy" "lambda_basic_execution_policy" {
  name = "lambda-basic-execution-policy-${var.environment}"
  role = aws_iam_role.lambda_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:/aws/lambda/${var.environment}/*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey"
        ]
        Resource = "arn:aws:kms:${var.aws_region}:${var.account_id}:key/${var.kms_key_id}"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_vpc_access_policy" {
  name = "lambda-vpc-access-policy-${var.environment}"
  role = aws_iam_role.lambda_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "antifraud_lambda_role" {
  name = "antifraud-lambda-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  tags = merge(var.common_tags, { Name = "antifraud-lambda-role-${var.environment}" })
}

resource "aws_iam_role_policy" "antifraud_policy" {
  name = "antifraud-policy-${var.environment}"
  role = aws_iam_role.antifraud_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query"
        ]
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.account_id}:table/${var.fraud_detection_table}"
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:DescribeTable"
        ]
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.account_id}:table/${var.fraud_detection_table}"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${var.account_id}:secret:antifraud/*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = "arn:aws:kms:${var.aws_region}:${var.account_id}:key/${var.kms_key_id}"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "dynamodb.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "settlement_lambda_role" {
  name = "settlement-lambda-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  tags = merge(var.common_tags, { Name = "settlement-lambda-role-${var.environment}" })
}

resource "aws_iam_role_policy" "settlement_policy" {
  name = "settlement-policy-${var.environment}"
  role = aws_iam_role.settlement_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query"
        ]
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.account_id}:table/${var.settlement_table}"
      },
      {
        Effect = "Allow"
        Action = [
          "rds:DescribeDBInstances"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${var.account_id}:secret:settlement/*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:Encrypt"
        ]
        Resource = "arn:aws:kms:${var.aws_region}:${var.account_id}:key/${var.kms_key_id}"
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = "arn:aws:sqs:${var.aws_region}:${var.account_id}:${var.environment}-settlement-queue"
      }
    ]
  })
}

resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
  tags = merge(var.common_tags, { Name = "rds-monitoring-role-${var.environment}" })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_enhanced" {
  role = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_iam_role" "alb_access_logs_role" {
  name = "alb-access-logs-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        }
      }
    ]
  })
  tags = merge(var.common_tags, { Name = "alb-access-logs-role-${var.environment}" })
}

resource "aws_iam_role_policy" "alb_access_logs_policy" {
  name = "alb-access-logs-policy-${var.environment}"
  role = aws_iam_role.alb_access_logs_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${var.alb_logs_bucket}/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile-${var.environment}"
  role = aws_iam_role.lambda_execution_role.name
  tags = merge(var.common_tags, { Name = "ec2-instance-profile-${var.environment}" })
}

// === ARCHIVO: modules/security/kms.tf ===
resource "aws_kms_key" "payments_master_key" {
  description = "Master KMS key for payments encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  tags = merge(var.common_tags, {
    Name = "payments-master-key-${var.environment}"
    Purpose = "encryption-master"
  })
}

resource "aws_kms_alias" "payments_master_key_alias" {
  name = "alias/payments-master-key-${var.environment}"
  target_key_id = aws_kms_key.payments_master_key.key_id
}

resource "aws_kms_key" "rds_encryption_key" {
  description = "KMS key for RDS database encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "rds-key-policy-${var.environment}"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow RDS to use the key"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "rds.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "rds-encryption-key-${var.environment}"
    Purpose = "rds-encryption"
  })
}

resource "aws_kms_alias" "rds_encryption_key_alias" {
  name = "alias/rds-encryption-key-${var.environment}"
  target_key_id = aws_kms_key.rds_encryption_key.key_id
}

resource "aws_kms_key" "s3_encryption_key" {
  description = "KMS key for S3 bucket encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "s3-key-policy-${var.environment}"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow S3 to use the key for encryption"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "s3.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "s3-encryption-key-${var.environment}"
    Purpose = "s3-encryption"
  })
}

resource "aws_kms_alias" "s3_encryption_key_alias" {
  name = "alias/s3-encryption-key-${var.environment}"
  target_key_id = aws_kms_key.s3_encryption_key.key_id
}

resource "aws_kms_key" "dynamodb_encryption_key" {
  description = "KMS key for DynamoDB table encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "dynamodb-key-policy-${var.environment}"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow DynamoDB to use the key"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "dynamodb.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "dynamodb-encryption-key-${var.environment}"
    Purpose = "dynamodb-encryption"
  })
}

resource "aws_kms_alias" "dynamodb_encryption_key_alias" {
  name = "alias/dynamodb-encryption-key-${var.environment}"
  target_key_id = aws_kms_key.dynamodb_encryption_key.key_id
}

resource "aws_kms_key" "alb_encryption_key" {
  description = "KMS key for ALB TLS termination in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  tags = merge(var.common_tags, {
    Name = "alb-tls-key-${var.environment}"
    Purpose = "alb-tls-termination"
  })
}

resource "aws_kms_alias" "alb_encryption_key_alias" {
  name = "alias/alb-tls-key-${var.environment}"
  target_key_id = aws_kms_key.alb_encryption_key.key_id
}

resource "aws_kms_key" "logs_encryption_key" {
  description = "KMS key for CloudWatch Logs encryption in ${var.environment}"
  key_usage = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  deletion_window_in_days = 30
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "logs-key-policy-${var.environment}"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow CloudWatch Logs to use the key"
        Effect = "Allow"
        Principal = {
          Service = "logs.${var.aws_region}.amazonaws.com"
        }
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "logs.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Name = "logs-encryption-key-${var.environment}"
    Purpose = "cloudwatch-logs-encryption"
  })
}

resource "aws_kms_alias" "logs_encryption_key_alias" {
  name = "alias/logs-encryption-key-${var.environment}"
  target_key_id = aws_kms_key.logs_encryption_key.key_id
}

// === ARCHIVO: modules/services/lambda.tf ===
resource "aws_lambda_function" "antifraud_engine" {
  filename = "../../lambda/antifraud-engine.zip"
  function_name = "antifraud-engine-${var.environment}"
  role = aws_iam_role.antifraud_lambda_role.arn
  handler = "com.payments.antifraud.Handler"
  source_code_hash = filebase64sha256("../../lambda/antifraud-engine.zip")
  runtime = "java17"
  timeout = 30
  memory_size = 512
  ephemeral_storage = {
    size = 512
  }
  environment {
    variables = {
      DYNAMODB_TABLE = var.fraud_detection_table
      KMS_KEY_ID = aws_kms_key.payments_master_key.key_id
      ENVIRONMENT = var.environment
      LOG_LEVEL = "INFO"
    }
  }
  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }
  tags = merge(var.common_tags, {
    Name = "antifraud-engine-${var.environment}"
    Component = "antifraud"
    CostCenter = var.cost_center
  })
}

resource "aws_lambda_function" "settlement_engine" {
  filename = "../../lambda/settlement-engine.zip"
  function_name = "settlement-engine-${var.environment}"
  role = aws_iam_role.settlement_lambda_role.arn
  handler = "com.payments.settlement.Handler"
  source_code_hash = filebase64sha256("../../lambda/settlement-engine.zip")
  runtime = "java17"
  timeout = 300
  memory_size = 1024
  ephemeral_storage = {
    size = 1024
  }
  environment {
    variables = {
      DYNAMODB_TABLE = var.settlement_table
      RDS_ENDPOINT = var.rds_endpoint
      SETTLEMENT_QUEUE_URL = "https://sqs.${var.aws_region}.amazonaws.com/${var.account_id}/${var.environment}-settlement-queue"
      KMS_KEY_ID = aws_kms_key.payments_master_key.key_id
      ENVIRONMENT = var.environment
      LOG_LEVEL = "INFO"
    }
  }
  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }
  tags = merge(var.common_tags, {
    Name = "settlement-engine-${var.environment}"
    Component = "settlement"
    CostCenter = var.cost_center
  })
}

resource "aws_lambda_function" "payment_processor" {
  filename = "../../lambda/payment-processor.zip"
  function_name = "payment-processor-${var.environment}"
  role = aws_iam_role.lambda_execution_role.arn
  handler = "com.payments.processor.Handler"
  source_code_hash = filebase64sha256("../../lambda/payment-processor.zip")
  runtime = "java17"
  timeout = 60
  memory_size = 1024
  ephemeral_storage = {
    size = 512
  }
  environment {
    variables = {
      ANTIFRAUD_FUNCTION_NAME = aws_lambda_function.antifraud_engine.function_name
      SETTLEMENT_FUNCTION_NAME = aws_lambda_function.settlement_engine.function_name
      KMS_KEY_ID = aws_kms_key.payments_master_key.key_id
      ENVIRONMENT = var.environment
      LOG_LEVEL = "INFO"
      TRANSACTION_TABLE = var.transaction_table
    }
  }
  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }
  tags = merge(var.common_tags, {
    Name = "payment-processor-${var.environment}"
    Component = "payment-processor"
    CostCenter = var.cost_center
  })
}

resource "aws_lambda_function" "risk_scoring" {
  filename = "../../lambda/risk-scoring.zip"
  function_name = "risk-scoring-${var.environment}"
  role = aws_iam_role.antifraud_lambda_role.arn
  handler = "com.payments.risk.Handler"
  source_code_hash = filebase64sha256("../../lambda/risk-scoring.zip")
  runtime = "java17"
  timeout = 45
  memory_size = 512
  ephemeral_storage = {
    size = 512
  }
  environment {
    variables = {
      DYNAMODB_TABLE = var.fraud_detection_table
      KMS_KEY_ID = aws_kms_key.payments_master_key.key_id
      ENVIRONMENT = var.environment
      LOG_LEVEL = "INFO"
      RISK_THRESHOLD = "0.75"
    }
  }
  vpc_config {
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }
  tags = merge(var.common_tags, {
    Name = "risk-scoring-${var.environment}"
    Component = "risk-scoring"
    CostCenter = var.cost_center
  })
}

resource "aws_lambda_permission" "allow_alb_invoke_antifraud" {
  statement_id = "AllowExecutionFromALB"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.antifraud_engine.function_name
  principal = "elasticloadbalancing.amazonaws.com"
  source_arn = "arn:aws:elasticloadbalancing:${var.aws_region}:${var.account_id}:targetgroup/*/*"
}

resource "aws_lambda_permission" "allow_api_gateway_invoke_processor" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.payment_processor.function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.account_id}:*/*"
}

resource "aws_lambda_event_source_mapping" "settlement_queue_mapping" {
  event_source_arn = "arn:aws:sqs:${var.aws_region}:${var.account_id}:${var.environment}-settlement-queue"
  function_name = aws_lambda_function.settlement_engine.function_name
  batch_size = 10
  maximum_record_age_in_seconds = 300
  bisect_batch_on_function_error = true
  destination_config {
    on_failure {
      destination_arn = "arn:aws:sqs:${var.aws_region}:${var.account_id}:${var.environment}-settlement-dlq"
    }
  }
}

resource "aws_lambda_alias" "antifraud_production" {
  name = "production"
  function_name = aws_lambda_function.antifraud_engine.function_name
  function_version = "$LATEST"
}

resource "aws_lambda_alias" "settlement_production" {
  name = "production"
  function_name = aws_lambda_function.settlement_engine.function_name
  function_version = "$LATEST"
}

resource "aws_lambda_provisioned_concurrency_config" "antifraud_provisioned" {
  function_name = aws_lambda_function.antifraud_engine.function_name
  qualifier = aws_lambda_alias.antifraud_production.name
  provisioned_concurrent_executions = 5
}

resource "aws_cloudwatch_log_group" "antifraud_logs" {
  name = "/aws/lambda/${aws_lambda_function.antifraud_engine.function_name}"
  retention_in_days = 90
  kms_key_id = aws_kms_key.logs_encryption_key.arn
  tags = merge(var.common_tags, { Name = "antifraud-logs-${var.environment}" })
}

resource "aws_cloudwatch_log_group" "settlement_logs" {
  name = "/aws/lambda/${aws_lambda_function.settlement_engine.function_name}"
  retention_in_days = 90
  kms_key_id = aws_kms_key.logs_encryption_key.arn
  tags = merge(var.common_tags, { Name = "settlement-logs-${var.environment}" })
}

resource "aws_cloudwatch_log_group" "payment_processor_logs" {
  name = "/aws/lambda/${aws_lambda_function.payment_processor.function_name}"
  retention_in_days = 90
  kms_key_id = aws_kms_key.logs_encryption_key.arn
  tags = merge(var.common_tags, { Name = "payment-processor-logs-${var.environment}" })
}


// === ARCHIVO: modules/services/rds.tf ===
resource "aws_db_subnet_group" "pagos_subnet_group" {
  name       = "pagos-db-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-db-subnet-group"
      Description = "Subnets para la base de datos RDS del sistema de pagos"
    }
  )
}
resource "aws_kms_key" "rds_encryption_key" {
  description             = "KMS key para cifrado en reposo de RDS de pagos"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-rds-kms-key"
      Environment = var.environment
    }
  )
}
resource "aws_kms_alias" "rds_encryption_alias" {
  name          = "alias/pagos-rds-kms"
  target_key_id = aws_kms_key.rds_encryption_key.key_id
}
resource "aws_db_instance" "pagos_db" {
  identifier             = "pagos-transactions-db"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  max_allocated_storage  = var.db_max_allocated_storage
  storage_type           = "gp3"
  storage_encrypted      = true
  kms_key_id             = aws_kms_key.rds_encryption_key.arn
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = 5432
  db_subnet_group_name   = aws_db_subnet_group.pagos_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_pagos.id]
  multi_az               = var.environment == "prod" ? true : false
  backup_retention_period = var.db_backup_retention
  backup_window          = "03:00-04:00"
  maintenance_window     = "mon:04:00-mon:05:00"
  skip_final_snapshot    = var.environment != "prod"
  final_snapshot_identifier = var.environment == "prod" ? "pagos-db-final-snapshot-${var.environment}" : null
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  performance_insights_enabled = true
  performance_insights_kms_key_id = aws_kms_key.rds_encryption_key.arn
  deletion_protection      = var.environment == "prod" ? true : false
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-transactions-db"
      Description = "Base de datos RDS para almacenamiento de transacciones de pago"
      Tier        = "MissionCritical"
    }
  )
}
resource "aws_security_group" "rds_pagos" {
  name        = "sg-rds-pagos"
  description = "Security group para RDS del sistema de pagos"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Acceso desde aplicaciones de pagos"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }
  ingress {
    description     = "Acceso desde servicios de monitoreo"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.monitoring_security_group_id]
  }
  egress {
    description = "Salida a internet para actualizaciones"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0/0"]
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "sg-rds-pagos"
      Description = "SG para RDS - acceso limitado a servicios autorizados"
    }
  )
}
resource "aws_db_instance" "auditoria_db" {
  identifier             = "pagos-auditoria-db"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = var.db_instance_class_auditoria
  allocated_storage      = var.db_allocated_storage_auditoria
  max_allocated_storage  = var.db_max_allocated_storage_auditoria
  storage_type           = "gp3"
  storage_encrypted      = true
  kms_key_id             = aws_kms_key.rds_encryption_key.arn
  db_name                = var.db_name_auditoria
  username               = var.db_username
  password               = var.db_password
  port                   = 5432
  db_subnet_group_name   = aws_db_subnet_group.pagos_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_auditoria.id]
  multi_az               = var.environment == "prod" ? true : false
  backup_retention_period = 30
  backup_window          = "02:00-03:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  skip_final_snapshot    = var.environment != "prod"
  final_snapshot_identifier = var.environment == "prod" ? "pagos-auditoria-final-snapshot-${var.environment}" : null
  enabled_cloudwatch_logs_exports = ["postgresql"]
  performance_insights_enabled = true
  performance_insights_kms_key_id = aws_kms_key.rds_encryption_key.arn
  deletion_protection      = true
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-auditoria-db"
      Description = "Base de datos RDS para logs de auditoría del sistema de pagos"
      Compliance  = "PCI-DSS"
    }
  )
}
resource "aws_security_group" "rds_auditoria" {
  name        = "sg-rds-auditoria"
  description = "Security group para RDS de auditoría"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Acceso desde ALB de auditoría"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }
  egress {
    description = "Salida a internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0/0"]
  }
  tags = merge(
    var.common_tags,
    {
      Name        = "sg-rds-auditoria"
      Description = "SG para RDS auditoría - PCI-DSS compliant"
    }
  )
}
resource "aws_s3_bucket" "rds_backup_bucket" {
  bucket = "pagos-rds-backups-${var.environment}"
  tags = merge(
    var.common_tags,
    {
      Name        = "pagos-rds-backups"
      Description = "Bucket para backups automatizados de RDS"
    }
  )
}
resource "aws_s3_bucket_server_side_encryption_configuration" "rds_backup_bucket_encryption" {
  bucket = aws_s3_bucket.rds_backup_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_key_arn = aws_kms_key.rds_encryption_key.arn
      sse_algorithm = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_versioning" "rds_backup_bucket_versioning" {
  bucket = aws_s3_bucket.rds_backup_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "rds_backup_bucket_pab" {
  bucket = aws_s3_bucket.rds_backup_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
// === ARCHIVO: modules/services/alb.tf ===
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


// === ARCHIVO: environments/dev/terraform.tfvars ===
# =============================================================================
# Configuración del entorno de DESARROLLO
# =============================================================================
# Este archivo contiene los valores de variables específicos para el ambiente
# de desarrollo. Los valores están optimizados para pruebas locales y costos
# mínimos, con instancias pequeñas y sin redundancia multi-AZ.
# =============================================================================

# -----------------------------------------------------------------------------
# Configuración de Red - VPC y Subredes
# -----------------------------------------------------------------------------
environment               = "dev"
environment_short         = "d"
vpc_cidr                  = "10.0.0.0/16"

# Subredes públicas - Monitoreo y auditoría (una sola AZ para dev)
public_subnet_1_cidr      = "10.0.1.0/24"
public_subnet_2_cidr      = "10.0.2.0/24"
availability_zone_1       = "us-east-1a"
availability_zone_2       = "us-east-1b"

# Subredes privadas - Servicios de pago (una sola AZ para dev)
private_subnet_pagos_1_cidr   = "10.0.10.0/24"
private_subnet_pagos_2_cidr   = "10.0.11.0/24"
private_subnet_antifraude_1_cidr = "10.0.20.0/24"
private_subnet_antifraude_2_cidr = "10.0.21.0/24"
private_subnet_buro_1_cidr    = "10.0.30.0/24"
private_subnet_buro_2_cidr    = "10.0.31.0/24"
private_subnet_liquidacion_1_cidr = "10.0.40.0/24"
private_subnet_liquidacion_2_cidr = "10.0.41.0/24"

# NAT Gateway - Una sola instancia para desarrollo
enable_nat_gateway        = true
single_nat_gateway        = true

# -----------------------------------------------------------------------------
# Configuración de Servicios - Instancias pequeñas para desarrollo
# -----------------------------------------------------------------------------

# RDS - Base de datos de pagos (instancia pequeña, sin réplicas)
rds_instance_class       = "db.t3.micro"
rds_allocated_storage    = 20
rds_multi_az              = false
rds_engine_version        = "15.4"

# Lambda - Funciones serverless para procesamiento de pagos
lambda_memory_sizes = {
  originador_pagos   = 128
  motor_antifraude   = 256
  buro_riesgos       = 128
  sistema_liquidacion = 256
}

lambda_timeout = {
  originador_pagos   = 30
  motor_antifraude   = 60
  buro_riesgos       = 30
  sistema_liquidacion = 120
}

# ALB - Balanceador de carga (instancia pequeña)
alb_type                = "application"
alb_enable_deletion_protection = false
alb_idle_timeout        = 60

# -----------------------------------------------------------------------------
# Configuración de Seguridad - Políticas restrictivas para dev
# -----------------------------------------------------------------------------

# KMS - Cifrado
kms_key_administrators = ["arn:aws:iam::123456789012:user/dev-admin"]
kms_key_users          = ["arn:aws:iam::123456789012:user/dev-user"]
enable_kms_rotation    = false

# IAM - Roles con permisos mínimos para desarrollo
iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/dev-permissions-boundary"

# Security Groups - Puertos restringidos para dev
allowed_ssh_cidrs       = ["10.0.0.0/16"]
allowed_https_cidrs     = ["0.0.0.0/0"]
allowed_mgmt_cidrs      = ["10.0.0.0/16"]

# -----------------------------------------------------------------------------
# Etiquetas obligatorias para optimización de costos
# -----------------------------------------------------------------------------
tags = {
  Environment     = "dev"
  CostCenter      = "pagos-dev"
  Owner           = "equipo-pagos"
  Project         = "red-pagos-segura"
  Compliance      = "PCI-DSS"
  Monitoring      = "enabled"
  Backup          = "daily"
}

# -----------------------------------------------------------------------------
# Configuración de Observabilidad
# -----------------------------------------------------------------------------
alarm_email              = "dev-alerts@empresa.com"
log_retention_days      = 7
enable_vpc_flow_logs    = false
enable_cloudwatch_logs  = true

# -----------------------------------------------------------------------------
# Configuración de Alta Disponibilidad (reducida para dev)
# -----------------------------------------------------------------------------
enable_deletion_protection = false
backup_retention_days   = 7
rto_minutes             = 60
rpo_minutes             = 30

// === ARCHIVO: environments/qa/terraform.tfvars ===
# =============================================================================
# Configuración del entorno de QA
# =============================================================================
# Este archivo contiene los valores de variables específicos para el ambiente
# de QA. Los valores reflejan un ambiente de pruebas más representativo con
# instancias medianas, configuración de seguridad reforzada y capacidad de
# pruebas de carga. Incluye redundancia básica en una zona de disponibilidad.
# =============================================================================

# -----------------------------------------------------------------------------
# Configuración de Red - VPC y Subredes
# -----------------------------------------------------------------------------
environment               = "qa"
environment_short         = "q"
vpc_cidr                  = "10.1.0.0/16"

# Subredes públicas - Monitoreo y auditoría (dos AZ para QA)
public_subnet_1_cidr      = "10.1.1.0/24"
public_subnet_2_cidr      = "10.1.2.0/24"
availability_zone_1       = "us-east-1a"
availability_zone_2       = "us-east-1b"

# Subredes privadas - Servicios de pago (dos AZ para QA)
private_subnet_pagos_1_cidr   = "10.1.10.0/24"
private_subnet_pagos_2_cidr   = "10.1.11.0/24"
private_subnet_antifraude_1_cidr = "10.1.20.0/24"
private_subnet_antifraude_2_cidr = "10.1.21.0/24"
private_subnet_buro_1_cidr    = "10.1.30.0/24"
private_subnet_buro_2_cidr    = "10.1.31.0/24"
private_subnet_liquidacion_1_cidr = "10.1.40.0/24"
private_subnet_liquidacion_2_cidr = "10.1.41.0/24"

# NAT Gateway - Alta disponibilidad en QA (una por AZ)
enable_nat_gateway        = true
single_nat_gateway        = false

# -----------------------------------------------------------------------------
# Configuración de Servicios - Instancias medianas para QA
# -----------------------------------------------------------------------------

# RDS - Base de datos de pagos (instancia mediana, standby en otra AZ)
rds_instance_class       = "db.t3.medium"
rds_allocated_storage    = 50
rds_multi_az              = true
rds_engine_version        = "15.4"

# Lambda - Funciones serverless para procesamiento de pagos
lambda_memory_sizes = {
  originador_pagos   = 256
  motor_antifraude   = 512
  buro_riesgos       = 256
  sistema_liquidacion = 512
}

lambda_timeout = {
  originador_pagos   = 60
  motor_antifraude   = 90
  buro_riesgos       = 60
  sistema_liquidacion = 180
}

# ALB - Balanceador de carga (instancia mediana)
alb_type                = "application"
alb_enable_deletion_protection = true
alb_idle_timeout        = 60

# -----------------------------------------------------------------------------
# Configuración de Seguridad - Políticas más restrictivas para QA
# -----------------------------------------------------------------------------

# KMS - Cifrado con rotación habilitada
kms_key_administrators = ["arn:aws:iam::123456789012:user/qa-admin", "arn:aws:iam::123456789012:role/qa-automation"]
kms_key_users          = ["arn:aws:iam::123456789012:user/qa-user", "arn:aws:iam::123456789012:role/qa-app-role"]
enable_kms_rotation    = true

# IAM - Roles con permisos específicos por servicio
iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/qa-permissions-boundary"

# Security Groups - Puertos más restrictivos para QA
allowed_ssh_cidrs       = ["10.1.0.0/16", "172.16.0.0/12"]
allowed_https_cidrs     = ["10.0.0.0/8"]
allowed_mgmt_cidrs      = ["10.1.0.0/16", "172.16.0.0/12"]

# -----------------------------------------------------------------------------
# Etiquetas obligatorias para optimización de costos
# -----------------------------------------------------------------------------
tags = {
  Environment     = "qa"
  CostCenter      = "pagos-qa"
  Owner           = "equipo-pagos"
  Project         = "red-pagos-segura"
  Compliance      = "PCI-DSS"
  Monitoring      = "enabled"
  Backup          = "daily"
  DataClassification = "confidential"
}

# -----------------------------------------------------------------------------
# Configuración de Observabilidad
# -----------------------------------------------------------------------------
alarm_email              = "qa-alerts@empresa.com"
log_retention_days      = 14
enable_vpc_flow_logs    = true
enable_cloudwatch_logs  = true

# -----------------------------------------------------------------------------
# Configuración de Alta Disponibilidad
# -----------------------------------------------------------------------------
enable_deletion_protection = true
backup_retention_days   = 14
rto_minutes             = 30
rpo_minutes             = 15

// === ARCHIVO: environments/prod/terraform.tfvars ===
# =============================================================================
# Configuración del entorno de PRODUCCIÓN
# =============================================================================
# Este archivo contiene los valores de variables específicos para el ambiente
# de producción. Los valores están optimizados para alta disponibilidad con
# instancias grandes, redundancia multi-AZ, cifrado obligatorio y todas las
# medidas de seguridad habilitadas. Cumple con los requisitos de 10,000 TPS
# y SLA 99.9% para el sistema de pagos.
# =============================================================================

# -----------------------------------------------------------------------------
# Configuración de Red - VPC y Subredes
# -----------------------------------------------------------------------------
environment               = "prod"
environment_short         = "p"
vpc_cidr                  = "10.2.0.0/16"

# Subredes públicas - Monitoreo y auditoría (tres AZ para alta disponibilidad)
public_subnet_1_cidr      = "10.2.1.0/24"
public_subnet_2_cidr      = "10.2.2.0/24"
public_subnet_3_cidr      = "10.2.3.0/24"
availability_zone_1       = "us-east-1a"
availability_zone_2       = "us-east-1b"
availability_zone_3       = "us-east-1c"

# Subredes privadas - Servicios de pago (tres AZ para producción)
private_subnet_pagos_1_cidr   = "10.2.10.0/24"
private_subnet_pagos_2_cidr   = "10.2.11.0/24"
private_subnet_pagos_3_cidr   = "10.2.12.0/24"
private_subnet_antifraude_1_cidr = "10.2.20.0/24"
private_subnet_antifraude_2_cidr = "10.2.21.0/24"
private_subnet_antifraude_3_cidr = "10.2.22.0/24"
private_subnet_buro_1_cidr    = "10.2.30.0/24"
private_subnet_buro_2_cidr    = "10.2.31.0/24"
private_subnet_buro_3_cidr    = "10.2.32.0/24"
private_subnet_liquidacion_1_cidr = "10.2.40.0/24"
private_subnet_liquidacion_2_cidr = "10.2.41.0/24"
private_subnet_liquidacion_3_cidr = "10.2.42.0/24"

# NAT Gateway - Alta disponibilidad (una por AZ en prod)
enable_nat_gateway        = true
single_nat_gateway        = false

# -----------------------------------------------------------------------------
# Configuración de Servicios - Instancias grandes para producción
# -----------------------------------------------------------------------------

# RDS - Base de datos de pagos (instancia grande, multi-AZ completo)
rds_instance_class       = "db.r6g.large"
rds_allocated_storage    = 200
rds_multi_az              = true
rds_engine_version        = "15.4"
rds_backup_retention_days = 30
rds_performance_insights  = true

# Lambda - Funciones serverless para procesamiento de pagos (alta concurrencia)
lambda_memory_sizes = {
  originador_pagos   = 1024
  motor_antifraude   = 2048
  buro_riesgos       = 1024
  sistema_liquidacion = 2048
}

lambda_timeout = {
  originador_pagos   = 120
  motor_antifraude   = 180
  buro_riesgos       = 120
  sistema_liquidacion = 300
}

lambda_provisioned_concurrency = {
  originador_pagos   = 10
  motor_antifraude   = 20
  buro_riesgos       = 10
  sistema_liquidacion = 20
}

# ALB - Balanceador de carga de producción con alta disponibilidad
alb_type                = "application"
alb_enable_deletion_protection = true
alb_idle_timeout        = 60
alb_enable_waf          = true
alb_ssl_policy          = "ELBSecurityPolicy-TLS-1-2-2021-07"

# -----------------------------------------------------------------------------
# Configuración de Seguridad - Máxima restricción para producción
# -----------------------------------------------------------------------------

# KMS - Cifrado con rotación obligatoria y claves separadas por servicio
kms_key_administrators = [
  "arn:aws:iam::123456789012:user/prod-admin",
  "arn:aws:iam::123456789012:role/prod-automation",
  "arn:aws:iam::123456789012:root"
]
kms_key_users          = [
  "arn:aws:iam::123456789012:role/prod-app-role",
  "arn:aws:iam::123456789012:role/prod-lambda-role"
]
enable_kms_rotation    = true
kms_key_usage          = "ENCRYPT_DECRYPT"

# IAM - Roles con permisos mínimos y políticas inline específicas
iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/prod-permissions-boundary"
iam_enable_audit       = true
iam_session_duration   = 43200

# Security Groups - Solo IPs específicas para producción
allowed_ssh_cidrs       = ["10.2.0.0/16"]
allowed_https_cidrs     = ["10.0.0.0/8"]
allowed_mgmt_cidrs      = ["10.2.0.0/16"]

# WAF - Web Application Firewall habilitado
waf_enabled            = true
waf_rules = [
  "AWSManagedRulesCommonRuleSet",
  "AWSManagedRulesSQLiRuleSet",
  "AWSManagedRulesKnownBadInputsRuleSet"
]

# -----------------------------------------------------------------------------
# Etiquetas obligatorias para optimización de costos y gobierno
# -----------------------------------------------------------------------------
tags = {
  Environment       = "prod"
  CostCenter        = "pagos-prod"
  Owner             = "equipo-pagos"
  Project           = "red-pagos-segura"
  Compliance        = "PCI-DSS"
  Monitoring        = "enabled"
  Backup            = "hourly"
  DataClassification = "restricted"
  SLA               = "99.9"
  ThroughputTarget  = "10000-TPS"
}

# -----------------------------------------------------------------------------
# Configuración de Observabilidad - Completa para producción
# -----------------------------------------------------------------------------
alarm_email              = "prod-operations@empresa.com"
log_retention_days      = 90
enable_vpc_flow_logs    = true
enable_cloudwatch_logs  = true
enable_detailed_monitoring = true
enable_metrics          = true

# Alarmas específicas para el sistema de pagos
alarm_thresholds = {
  cpu_utilization    = 75
  memory_utilization = 80
  disk_utilization   = 85
  network_throughput = 1000000000
  rds_cpu            = 70
  rds_connections    = 80
  lambda_errors      = 1
  lambda_throttles   = 5
  alb_target_response_time = 1000
  alb_5xx_errors      = 10
}

# -----------------------------------------------------------------------------
# Configuración de Alta Disponibilidad y Recuperación ante Desastres
# -----------------------------------------------------------------------------
enable_deletion_protection = true
backup_retention_days   = 30
rto_minutes             = 15
rpo_minutes             = 5

# Multi-Region para recuperación ante desastres
enable_cross_region_backup = true
backup_replication_region = "us-west-2"
replication_retention_days = 90

# DNS y Routing
enable_route53_health_checks = true
health_check_interval     = 30
failover_threshold        = 3


// === ARCHIVO: diagram/red_pagos.drawio ===
<mxfile host="app.diagrams.net" modified="2024-01-15T10:00:00.000Z" agent="CloudOps-Terraform" version="21.0.0">
  <diagram name="Topologia Red Segura Pagos" id="red-segura-pagos">
    <mxGraphModel dx="1200" dy="800" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="900" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <!-- Titulo del diagrama -->
        <mxCell id="title" value="Topologia de Red Segura - Entorno de Pagos" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=20;fontStyle=1;fontColor=#1F2937;" vertex="1" parent="1">
          <mxGeometry x="400" y="20" width="400" height="40" as="geometry" />
        </mxCell>
        <!-- Metadatos del diagrama -->
        <mxCell id="metadata" value="Throughput: 10,000 TPS | SLA: 99.9% | Entorno: Produccion" style="text;html=1;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;fontSize=12;fontStyle=2;fontColor=#6B7280;" vertex="1" parent="1">
          <mxGeometry x="350" y="60" width="500" height="20" as="geometry" />
        </mxCell>
        <!-- VPC Principal -->
        <mxCell id="vpc" value="VPC (10.0.0.0/16)" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#E5E7EB;strokeColor=#374151;strokeWidth=2;fontSize=14;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="80" y="100" width="1040" height="780" as="geometry" />
        </mxCell>
        <!-- Zona de Subredes Publicas -->
        <mxCell id="public-zone" value="ZONA PUBLICA (Internet-facing)" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#DBEAFE;strokeColor=#1D4ED8;strokeWidth=2;fontSize=12;fontStyle=1;fontColor=#1E40AF;" vertex="1" parent="1">
          <mxGeometry x="100" y="120" width="500" height="360" as="geometry" />
        </mxCell>
        <!-- Subred Publica - Monitoreo -->
        <mxCell id="subnet-publica-monitoreo" value="Subred Publica - Monitoreo&#xa;10.0.1.0/24&#xa;&#xa;Servicios:&#xa;- CloudWatch Agent&#xa;- Prometheus/Grafana&#xa;- Fluentd Collector" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#BFDBFE;strokeColor=#3B82F6;strokeWidth=1;fontSize=11;" vertex="1" parent="1">
          <mxGeometry x="120" y="150" width="220" height="150" as="geometry" />
        </mxCell>
        <!-- Subred Publica - Auditoria -->
        <mxCell id="subnet-publica-auditoria" value="Subred Publica - Auditoria&#xa;10.0.2.0/24&#xa;&#xa;Servicios:&#xa;- AWS CloudTrail&#xa;- VPC Flow Logs&#xa;- Config Rules" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#BFDBFE;strokeColor=#3B82F6;strokeWidth=1;fontSize=11;" vertex="1" parent="1">
          <mxGeometry x="360" y="150" width="220" height="150" as="geometry" />
        </mxCell>
        <!-- ALB en Subred Publica -->
        <mxCell id="alb" value="Application Load Balancer&#xa;---&#xa;TLS Termination&#xa;WAF Integration&#xa;DDoS Protection" style="shape=mxgraph.aws3.load_balancer;whiteSpace=wrap;html=1;fillColor=#FEF3C7;strokeColor=#D97706;strokeWidth=2;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="250" y="340" width="140" height="100" as="geometry" />
        </mxCell>
        <!-- Internet Gateway -->
        <mxCell id="igw" value="Internet Gateway" style="shape=mxgraph.aws3.internet_gateway;whiteSpace=wrap;html=1;fillColor=#FECACA;strokeColor=#DC2626;strokeWidth=2;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="520" y="340" width="60" height="60" as="geometry" />
        </mxCell>
        <!-- Zona de Subredes Privadas -->
        <mxCell id="private-zone" value="ZONA PRIVADA (Internal)" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#D1FAE5;strokeColor=#059669;strokeWidth=2;fontSize=12;fontStyle=1;fontColor=#065F46;" vertex="1" parent="1">
          <mxGeometry x="620" y="120" width="480" height="360" as="geometry" />
        </mxCell>
        <!-- Subred Privada - Pagos -->
        <mxCell id="subnet-privada-pagos" value="Subred Privada - Pagos&#xa;10.0.10.0/24&#xa;&#xa;Servicios:&#xa;- API Gateway Pagos&#xa;- Lambda Procesamiento&#xa;- DynamoDB Transacciones" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#A7F3D0;strokeColor=#10B981;strokeWidth=1;fontSize=11;" vertex="1" parent="1">
          <mxGeometry x="640" y="150" width="220" height="150" as="geometry" />
        </mxCell>
        <!-- Subred Privada - Servicios Internos -->
        <mxCell id="subnet-privada-servicios" value="Subred Privada - Servicios&#xa;10.0.11.0/24&#xa;&#xa;Servicios:&#xa;- Motor Antifraude&#xa;- Buró de Riesgos&#xa;- Liquidacion" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#A7F3D0;strokeColor=#10B981;strokeWidth=1;fontSize=11;" vertex="1" parent="1">
          <mxGeometry x="880" y="150" width="200" height="150" as="geometry" />
        </mxCell>
        <!-- RDS en Subred Privada -->
        <mxCell id="rds" value="Amazon RDS&#xa;PostgreSQL&#xa;---&#xa;Multi-AZ&#xa;Encrypted (KMS)&#xa;Read Replicas" style="shape=mxgraph.aws3.rds;whiteSpace=wrap;html=1;fillColor=#E0E7FF;strokeColor=#4F46E5;strokeWidth=2;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="780" y="340" width="120" height="100" as="geometry" />
        </mxCell>
        <!-- NAT Gateway -->
        <mxCell id="nat" value="NAT Gateway&#xa;(Alta Disponibilidad)" style="shape=mxgraph.aws3.nat_gateway;whiteSpace=wrap;html=1;fillColor=#FDE68A;strokeColor=#CA8A04;strokeWidth=2;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="640" y="340" width="80" height="80" as="geometry" />
        </mxCell>
        <!-- Route Tables -->
        <mxCell id="rt-publica" value="Route Table Publica&#xa;----------------&#xa;0.0.0.0/0 -> IGW&#xa;10.0.0.0/16 -> Local" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#F3F4F6;strokeColor=#6B7280;fontSize=9;" vertex="1" parent="1">
          <mxGeometry x="120" y="500" width="160" height="80" as="geometry" />
        </mxCell>
        <mxCell id="rt-privada" value="Route Table Privada&#xa;----------------&#xa;0.0.0.0/0 -> NAT&#xa;10.0.0.0/16 -> Local" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#F3F4F6;strokeColor=#6B7280;fontSize=9;" vertex="1" parent="1">
          <mxGeometry x="300" y="500" width="160" height="80" as="geometry" />
        </mxCell>
        <!-- Security Groups -->
        <mxCell id="sg-alb" value="Security Group: ALB&#xa;--------------------&#xa;Inbound:&#xa;- 443 (HTTPS) from 0.0.0.0/0&#xa;- 80 (HTTP) redirect to 443&#xa;&#xa;Outbound:&#xa;- 443 to Private Subnets" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#FEE2E2;strokeColor=#EF4444;fontSize=9;" vertex="1" parent="1">
          <mxGeometry x="640" y="500" width="180" height="100" as="geometry" />
        </mxCell>
        <mxCell id="sg-lambda" value="Security Group: Lambda&#xa;--------------------&#xa;Inbound:&#xa;- 443 from ALB SG&#xa;&#xa;Outbound:&#xa;- 443 to RDS&#xa;- 443 to DynamoDB&#xa;- 443 to External APIs" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#FEE2E2;strokeColor=#EF4444;fontSize=9;" vertex="1" parent="1">
          <mxGeometry x="840" y="500" width="180" height="100" as="geometry" />
        </mxCell>
        <mxCell id="sg-rds" value="Security Group: RDS&#xa;--------------------&#xa;Inbound:&#xa;- 5432 from Lambda SG&#xa;&#xa;Outbound:&#xa;None (Database)" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#FEE2E2;strokeColor=#EF4444;fontSize=9;" vertex="1" parent="1">
          <mxGeometry x="1040" y="500" width="160" height="100" as="geometry" />
        </mxCell>
        <!-- Actores del Sistema de Pagos -->
        <mxCell id="actores" value="ACTORES DEL SISTEMA" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#F3F4F6;strokeColor=#374151;strokeWidth=2;fontSize=12;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="80" y="620" width="1040" height="240" as="geometry" />
        </mxCell>
        <!-- Originador de Pagos -->
        <mxCell id="originador" value="Originador de Pagos&#xa;----------------&#xa;Entidad que inicia&#xa;las transacciones&#xa;&#xa;Comunicacion: HTTPS/TLS&#xa;Autenticacion: mTLS" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#E0E7FF;strokeColor=#4338CA;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="100" y="650" width="160" height="120" as="geometry" />
        </mxCell>
        <!-- Motor Antifraude -->
        <mxCell id="antifraude" value="Motor Antifraude&#xa;----------------&#xa;Analiza transacciones&#xa;en tiempo real&#xa;&#xa;Ubicacion: Private Subnet&#xa;Modelo: ML/Deep Learning" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#E0E7FF;strokeColor=#4338CA;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="280" y="650" width="160" height="120" as="geometry" />
        </mxCell>
        <!-- Buró de Riesgos -->
        <mxCell id="buro" value="Buro de Riesgos&#xa;----------------&#xa;Consulta historico&#xa;crediticio&#xa;&#xa;Ubicacion: Private Subnet&#xa;Integracion: API REST" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#E0E7FF;strokeColor=#4338CA;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="460" y="650" width="160" height="120" as="geometry" />
        </mxCell>
        <!-- Sistema de Liquidacion -->
        <mxCell id="liquidacion" value="Sistema de Liquidacion&#xa;----------------&#xa;Procesa compensacion&#xa;entre entidades&#xa;&#xa;Ubicacion: Private Subnet&#xa;Scheduler: Cron/EventBridge" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#E0E7FF;strokeColor=#4338CA;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="640" y="650" width="160" height="120" as="geometry" />
        </mxCell>
        <!-- Flujo de Datos -->
        <mxCell id="flujo" value="FLUJO DE DATOS&#xa;----------------&#xa;1. Originador -> ALB (443)&#xa;2. ALB -> Lambda (HTTPS)&#xa;3. Lambda -> Antifraude&#xa;4. Lambda -> Buró Riesgos&#xa;5. Lambda -> RDS (5432)&#xa;6. Lambda -> Liquidacion&#xa;7. Respuesta -> ALB -> Originador" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#FEF3C7;strokeColor=#D97706;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="820" y="650" width="200" height="140" as="geometry" />
        </mxCell>
        <!-- KMS - Cifrado -->
        <mxCell id="kms" value="AWS KMS&#xa;--------&#xa;Cifrado en&#xa;reposo:&#xa;- RDS&#xa;- DynamoDB&#xa;- S3 Buckets" style="shape=mxgraph.aws3.key_management_service;whiteSpace=wrap;html=1;fillColor=#FCE7F3;strokeColor=#DB2777;strokeWidth=2;fontSize=10;" vertex="1" parent="1">
          <mxGeometry x="1040" y="340" width="60" height="60" as="geometry" />
        </mxCell>
        <!-- Conexiones - ALB a Lambda -->
        <mxCell id="conn-alb-lambda" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#6B7280;strokeWidth=2;dashed=1;" edge="1" parent="1" source="alb" target="subnet-privada-pagos">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <!-- Conexion Internet a IGW -->
        <mxCell id="conn-internet-igw" value="Internet" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#DC2626;strokeWidth=2;" edge="1" parent="1">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="550" y="250" />
              <mxPoint x="550" y="370" />
            </Array>
          </mxGeometry>
        </mxCell>
        <!-- IGW a ALB -->
        <mxCell id="conn-igw-alb" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#D97706;strokeWidth=2;" edge="1" parent="1" source="igw" target="alb">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <!-- Lambda a RDS -->
        <mxCell id="conn-lambda-rds" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#4F46E5;strokeWidth=2;dashed=1;" edge="1" parent="1" source="subnet-privada-pagos" target="rds">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <!-- NAT Gateway a Internet -->
        <mxCell id="conn-nat-igw" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#CA8A04;strokeWidth=2;" edge="1" parent="1" source="nat" target="igw">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="680" y="370" />
            </Array>
          </mxGeometry>
        </mxCell>
        <!-- Notas de Seguridad -->
        <mxCell id="notas-seguridad" value="MEDIDAS DE SEGURIDAD IMPLEMENTADAS&#xa;--------------------------------------------&#xa;- Cifrado en reposo con KMS (AES-256)&#xa;- Cifrado en transito (TLS 1.3)&#xa;- Principle of Least Privilege en SG e IAM&#xa;- Segmentacion por subredes (Public/Private)&#xa;- NAT Gateway para salida controlada&#xa;- WAF en ALB para proteccion OWASP&#xa;- CloudTrail para auditoria&#xa;- VPC Flow Logs para monitoreo de red&#xa;- Multi-AZ para alta disponibilidad" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#FEF2F2;strokeColor=#B91C1C;fontSize=10;align=left;spacingLeft=10;" vertex="1" parent="1">
          <mxGeometry x="80" y="870" width="480" height="120" as="geometry" />
        </mxCell>
        <!-- Notas de Disponibilidad -->
        <mxCell id="notas-disponibilidad" value="ALTA DISPONIBILIDAD Y RTO/RPO&#xa;--------------------------------------------&#xa;- RDS: Multi-AZ con failover automatico&#xa;- Lambda: Ejecucion en multiples AZs&#xa;- ALB: Balanceo cross-zone&#xa;- NAT Gateway: Alta disponibilidad (1 por AZ)&#xa;- RTO: < 5 minutos&#xa;- RPO: < 1 minuto (replicacion sincrona)&#xa;- SLA: 99.9% (multi-AZ)" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#ECFDF5;strokeColor=#047857;fontSize=10;align=left;spacingLeft=10;" vertex="1" parent="1">
          <mxGeometry x="580" y="870" width="400" height="120" as="geometry" />
        </mxCell>
        <!-- Cost Optimization -->
        <mxCell id="cost-optimization" value="OPTIMIZACION DE COSTOS&#xa;--------------------------------&#xa;- Etiquetas obligatorias:&#xa;  * Name&#xa;  * Environment&#xa;  * CostCenter&#xa;  * Project&#xa;- Reserved Instances para RDS&#xa;- Lambda provisioned concurrency&#xa;- S3 lifecycle policies&#xa;- CloudWatch dashboards&#xa;  centralizados" style="rounded=0;whiteSpace=wrap;html=1;fillColor=#FFFBEB;strokeColor=#B45309;fontSize=10;align=left;spacingLeft=10;" vertex="1" parent="1">
          <mxGeometry x="1000" y="870" width="200" height="120" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>

// === ARCHIVO: variables.tf ===
variable "aws_region" {
  description = "Región primaria de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "secondary_region" {
  description = "Región secundaria de AWS para redundancia geográfica"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, qa, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El entorno debe ser uno de: dev, qa, prod"
  }
}

variable "cost_center" {
  description = "Centro de costos para etiquetado y optimización de gastos"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para nomenclatura de recursos"
  type        = string
}

variable "account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR principal para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El CIDR de la VPC debe ser una dirección de red válida"
  }
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para la región primaria"
  type        = list(string)
}

variable "secondary_availability_zones" {
  description = "Zonas de disponibilidad para la región secundaria"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs_pagos" {
  description = "Bloques CIDR para subredes privadas del dominio de pagos"
  type        = list(string)
}

variable "private_subnet_cidrs_monitoreo" {
  description = "Bloques CIDR para subredes privadas de monitoreo"
  type        = list(string)
}

variable "private_subnet_cidrs_auditoria" {
  description = "Bloques CIDR para subredes privadas de auditoría"
  type        = list(string)
}

variable "subnet_public_payments_cidr" {
  description = "CIDR para subred pública de pagos en AZ1"
  type        = string
}

variable "subnet_public_payments_cidr_az2" {
  description = "CIDR para subred pública de pagos en AZ2"
  type        = string
}

variable "subnet_public_monitoring_cidr" {
  description = "CIDR para subred pública de monitoreo en AZ1"
  type        = string
}

variable "subnet_public_monitoring_cidr_az2" {
  description = "CIDR para subred pública de monitoreo en AZ2"
  type        = string
}

variable "subnet_private_payments_cidr" {
  description = "CIDR para subred privada de pagos en AZ1"
  type        = string
}

variable "subnet_private_payments_cidr_az2" {
  description = "CIDR para subred privada de pagos en AZ2"
  type        = string
}

variable "subnet_private_database_cidr" {
  description = "CIDR para subred privada de base de datos en AZ1"
  type        = string
}

variable "subnet_private_database_cidr_az2" {
  description = "CIDR para subred privada de base de datos en AZ2"
  type        = string
}

variable "subnet_private_audit_cidr" {
  description = "CIDR para subred privada de auditoría en AZ1"
  type        = string
}

variable "subnet_private_audit_cidr_az2" {
  description = "CIDR para subred privada de auditoría en AZ2"
  type        = string
}

variable "nat_gateway_count" {
  description = "Cantidad de NAT Gateways a desplegar (1 por AZ o 1 único)"
  type        = number
  validation {
    condition     = var.nat_gateway_count >= 1 && var.nat_gateway_count <= 3
    error_message = "La cantidad de NAT Gateways debe estar entre 1 y 3"
  }
}

variable "enable_vpn_gateway" {
  description = "Habilitar VPN Gateway para acceso seguro a la VPC"
  type        = bool
  default     = false
}

variable "enable_transit_gateway" {
  description = "Habilitar Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR autorizados para acceso a servicios públicos"
  type        = list(string)
}

variable "enable_flow_logs" {
  description = "Habilitar VPC Flow Logs para observabilidad del tráfico"
  type        = bool
  default     = true
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para VPC Flow Logs (s3, cloud-watch-logs)"
  type        = string
  default     = "s3"
  validation {
    condition     = contains(["s3", "cloud-watch-logs"], var.flow_log_destination_type)
    error_message = "El tipo de destino debe ser s3 o cloud-watch-logs"
  }
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas adicionales para todos los recursos"
  type        = map(string)
  default     = {}
}

variable "s3_bucket_prefix" {
  description = "Prefijo para nombres de buckets S3"
  type        = string
}

variable "rds_instance_class" {
  description = "Clase de instancia RDS para la base de datos de pagos"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Almacenamiento allocated para RDS en GB"
  type        = number
}

variable "rds_multi_az" {
  description = "Habilitar despliegue Multi-AZ para RDS"
  type        = bool
  default     = true
}

variable "lambda_runtime" {
  description = "Runtime para funciones Lambda"
  type        = string
  default     = "python3.11"
}

variable "lambda_memory_size" {
  description = "Memoria en MB para funciones Lambda"
  type        = number
  default     = 256
}

variable "lambda_timeout" {
  description = "Timeout en segundos para funciones Lambda"
  type        = number
  default     = 30
}

variable "alb_timeout" {
  description = "Timeout de respuesta del ALB en segundos"
  type        = number
  default     = 60
}

variable "alb_deletion_protection" {
  description = "Habilitar protección contra eliminación del ALB"
  type        = bool
  default     = true
}

variable "kms_key_administrators" {
  description = "ARNs de usuarios que pueden administrar claves KMS"
  type        = list(string)
}

variable "kms_key_users" {
  description = "ARNs de usuarios que pueden usar claves KMS"
  type        = list(string)
}

variable "eks_cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  type        = string
  default     = ""
}

variable "eks_cluster_ca_cert" {
  description = "Certificado CA del cluster EKS (base64)"
  type        = string
  default     = ""
}

variable "eks_cluster_token" {
  description = "Token de acceso al cluster EKS"
  type        = string
  default     = ""
  sensitive   = true
}

variable "enable_waf" {
  description = "Habilitar AWS WAF para protección de aplicaciones"
  type        = bool
  default     = false
}

variable "cloudwatch_log_retention_days" {
  description = "Días de retención para logs de CloudWatch"
  type        = number
  default     = 90
  validation {
    condition     = var.cloudwatch_log_retention_days >= 1 && var.cloudwatch_log_retention_days <= 365
    error_message = "Los días de retención deben estar entre 1 y 365"
  }
}

variable "enable_guardduty" {
  description = "Habilitar Amazon GuardDuty para detección de amenazas"
  type        = bool
  default     = false
}

variable "rto_minutes" {
  description = "Recovery Time Objective en minutos"
  type        = number
  default     = 60
}

variable "rpo_minutes" {
  description = "Recovery Point Objective en minutos"
  type        = number
  default     = 15
}

// === ARCHIVO: modules/network/variables.tf ===
variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "region" {
  description = "Región de AWS"
  type        = string
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}

variable "cost_center" {
  description = "Centro de costos para etiquetado"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes para todos los recursos"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID de la VPC existente"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID del Internet Gateway"
  type        = string
}

variable "nat_gateway_id" {
  description = "ID del NAT Gateway"
  type        = string
}

variable "vpc_peering_connection_id" {
  description = "ID de la conexión de VPC Peering"
  type        = string
  default     = ""
}

variable "onpremises_cidr" {
  description = "Bloque CIDR de la red on-premises"
  type        = string
  default     = ""
}

variable "vpn_gateway_id" {
  description = "ID del VPN Gateway"
  type        = string
  default     = ""
}

variable "s3_endpoint_id" {
  description = "ID del endpoint de S3"
  type        = string
  default     = ""
}

variable "dynamodb_endpoint_id" {
  description = "ID del endpoint de DynamoDB"
  type        = string
  default     = ""
}

variable "public_subnet_ids" {
  description = "Lista de IDs de subredes públicas"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas"
  type        = list(string)
}

variable "pagos_db_subnet_ids" {
  description = "Lista de IDs de subredes de base de datos de pagos"
  type        = list(string)
}

variable "public_subnet_id" {
  description = "ID de la subred pública donde se desplegará el NAT Gateway"
  type        = string
}

// === ARCHIVO: modules/security/variables.tf ===
variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "cost_center" {
  description = "Centro de costos"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes"
  type        = map(string)
  default     = {}
}

variable "subnet_pagos_cidr" {
  description = "CIDR de la subred de pagos"
  type        = string
}

variable "subnet_rds_cidr" {
  description = "CIDR de la subred de RDS"
  type        = string
}

variable "subnet_monitoring_cidr" {
  description = "CIDR de la subred de monitoreo"
  type        = string
}

variable "subnet_antifraude_cidr" {
  description = "CIDR de la subred de antifraude"
  type        = string
}

variable "subnet_buro_cidr" {
  description = "CIDR de la subred del buró de riesgos"
  type        = string
}

variable "kms_key_id" {
  description = "ID de la clave KMS"
  type        = string
}

variable "fraud_detection_table" {
  description = "Nombre de la tabla de detección de fraude"
  type        = string
}

variable "settlement_table" {
  description = "Nombre de la tabla de liquidación"
  type        = string
}

variable "alb_logs_bucket" {
  description = "Nombre del bucket de logs del ALB"
  type        = string
}

// === ARCHIVO: modules/services/variables.tf ===
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "cost_center" {
  description = "Centro de costos"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Lista de IDs de subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs de subredes privadas"
  type        = list(string)
}

variable "lambda_security_group_id" {
  description = "ID del security group para Lambda"
  type        = string
}

variable "app_security_group_id" {
  description = "ID del security group de aplicaciones"
  type        = string
}

variable "monitoring_security_group_id" {
  description = "ID del security group de monitoreo"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID del security group del ALB"
  type        = string
}

variable "fraud_detection_table" {
  description = "Nombre de la tabla de detección de fraude"
  type        = string
}

variable "settlement_table" {
  description = "Nombre de la tabla de liquidación"
  type        = string
}

variable "transaction_table" {
  description = "Nombre de la tabla de transacciones"
  type        = string
}

variable "rds_endpoint" {
  description = "Endpoint de la instancia RDS"
  type        = string
}

variable "db_instance_class" {
  description = "Clase de instancia de RDS"
  type        = string
}

variable "db_allocated_storage" {
  description = "Almacenamiento allocated para RDS en GB"
  type        = number
}

variable "db_max_allocated_storage" {
  description = "Almacenamiento máximo para RDS"
  type        = number
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_backup_retention" {
  description = "Días de retención de backups"
  type        = number
  default     = 7
}

variable "db_instance_class_auditoria" {
  description = "Clase de instancia de RDS para auditoría"
  type        = string
}

variable "db_allocated_storage_auditoria" {
  description = "Almacenamiento allocated para RDS de auditoría"
  type        = number
}

variable "db_max_allocated_storage_auditoria" {
  description = "Almacenamiento máximo para RDS de auditoría"
  type        = number
}

variable "db_name_auditoria" {
  description = "Nombre de la base de datos de auditoría"
  type        = string
}

variable "alb_domain_name" {
  description = "Nombre de dominio para el ALB"
  type        = string
}

variable "alb_subject_alternative_names" {
  description = "Nombres alternativos para el certificado del ALB"
  type        = list(string)
  default     = []
}

variable "sns_topic_arn" {
  description = "ARN del topic SNS para alarmas"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}

```
