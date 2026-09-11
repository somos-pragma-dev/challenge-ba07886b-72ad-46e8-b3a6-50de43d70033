# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

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
- Título: Diseño de Red Segura para Entorno de Pagos
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Definición de Requisitos de Red — objetivo: Identificar y documentar los requisitos de red para el entorno de pagos. — entregable (NO resolver): Documento de requisitos de red.
- Fase 2: Diseño de la Topología de Red — objetivo: Crear un diseño detallado de la topología de red que cumpla con los requisitos definidos. — entregable (NO resolver): Diagrama de la topología de red.
- Fase 3: Implementación y Validación — objetivo: Implementar el diseño de la topología de red y validar su funcionamiento. — entregable (NO resolver): Documento de implementación y validación de la topología de red.

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

// === ARCHIVO: providers.tf ===
# Configuración de providers y versiones de Terraform
# Este archivo define los providers necesarios para el despliegue de infraestructura en AWS
# y especifica las restricciones de versión para garantizar compatibilidad

terraform {
  required_version = ">= 1.5, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider de AWS con configuración regional y opciones de comportamiento
# La región se define mediante variable de entorno AWS_DEFAULT_REGION o se sobrescribe en tfvars
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.common_tags
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = true

  endpoints {
    ec2        = "ec2.${var.aws_region}.amazonaws.com"
    elb        = "elasticloadbalancing.${var.aws_region}.amazonaws.com"
    iam        = "iam.${var.aws_region}.amazonaws.com"
    cloudwatch = "logs.${var.aws_region}.amazonaws.com"
  }
}

// === ARCHIVO: variables.tf ===
# Declaración de variables globales del proyecto de infraestructura
# Estas variables definen la configuración base que se aplica a todos los módulos
# Los valores se proporcionan a través de archivos terraform.tfvars por ambiente

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El ambiente debe ser uno de: dev, qa, prod"
  }
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block principal para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Debe ser un CIDR válido (ej. 10.0.0.0/16)"
  }
}

variable "availability_zones" {
  description = "Lista de AZs a utilizar en el entorno"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs para subredes privadas (aplicación)"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "CIDRs para subredes de base de datos"
  type        = list(string)
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para salida a internet desde subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar una única NAT Gateway para todas las subredes privadas (optimización de costos)"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "Habilitar VPN Gateway para conectividad híbrida"
  type        = bool
  default     = false
}

variable "enable_dx_gateway" {
  description = "Habilitar Direct Connect Gateway para conectividad dedicada"
  type        = bool
  default     = false
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para VPC Flow Logs (cloud-watch-logs, s3, kinesis-data-firehose)"
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_retention_days" {
  description = "Días de retención para logs de flujo de VPC"
  type        = number
  default     = 90
}

variable "enable_transit_gateway" {
  description = "Habilitar Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso a recursos públicos"
  type        = list(string)
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Habilitar DNS hostnames en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

// === ARCHIVO: modules/network/variables.tf ===
# Variables específicas del módulo de red (VPC, subredes, tablas de rutas, NAT Gateway)
# Este módulo encapsula toda la configuración relacionada con la topología de red
# incluyendo segmentación entre subredes públicas, privadas y de base de datos

variable "vpc_name" {
  description = "Nombre identificador para la VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block principal de la VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para las subredes"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para subredes públicas (con acceso a internet)"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Bloques CIDR para subredes privadas (aplicaciones, sin acceso directo a internet)"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Bloques CIDR para subredes de base de datos (aislamiento máximo)"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Determina si se crean NAT Gateways para permitir salida a internet desde subredes privadas"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Si es true, se crea una única NAT Gateway en lugar de una por AZ (ahorra costos)"
  type        = bool
}

variable "enable_vpn_gateway" {
  description = "Habilita el Virtual Private Gateway para conexiones VPN site-to-site"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Habilita la resolución de DNS hostnames dentro de la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilita el soporte de DNS dentro de la VPC"
  type        = bool
  default     = true
}

variable "enable_transit_gateway" {
  description = "Configura attachment al Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "transit_gateway_id" {
  description = "ID del Transit Gateway al cual conectar esta VPC"
  type        = string
  default     = ""
}

variable "map_public_ip_on_launch" {
  description = "Asignar IP pública automáticamente a instancias en subredes públicas"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Ambiente de despliegue para etiquetado"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "common_tags" {
  description = "Tags comunes heredados del proyecto"
  type        = map(string)
}

variable "nat_gateway_elastic_ips" {
  description = "Cantidad de Elastic IPs para NAT Gateways (debe coincidir con número de AZs si single_nat_gateway es false)"
  type        = number
  default     = 0
}

variable "enable_flow_log" {
  description = "Habilitar VPC Flow Logs para monitoreo de tráfico"
  type        = bool
  default     = true
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para flow logs: cloud-watch-logs, s3, o kinesis-data-firehose"
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_cloudwatch_log_group_name" {
  description = "Nombre del Log Group en CloudWatch para flow logs"
  type        = string
  default     = ""
}

variable "flow_log_cloudwatch_log_group_arn" {
  description = "ARN del Log Group de CloudWatch existente para flow logs"
  type        = string
  default     = ""
}

variable "flow_log_iam_role_arn" {
  description = "ARN del rol IAM para publicación de flow logs"
  type        = string
  default     = ""
}

variable "flow_log_traffic_type" {
  description = "Tipo de tráfico a registrar: ACCEPT, REJECT, o ALL"
  type        = string
  default     = "ALL"
}

variable "enable_classiclink" {
  description = "Habilitar ClassicLink para compatibilidad con EC2-Classic"
  type        = bool
  default     = false
}

variable "enable_ipv6" {
  description = "Habilitar IPv6 en la VPC"
  type        = bool
  default     = false
}

// === ARCHIVO: modules/security/variables.tf ===
# Variables específicas del módulo de seguridad
# Este módulo encapsula la configuración de IAM roles, políticas, security groups
# y otros recursos de seguridad necesarios para el entorno de pagos

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se aplicarán los security groups"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR autorizados para acceso a recursos"
  type        = list(string)
  default     = []
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos de seguridad"
  type        = map(string)
}

variable "enable_iam_roles" {
  description = "Habilitar la creación de roles IAM para los componentes"
  type        = bool
  default     = true
}

variable "enable_security_groups" {
  description = "Habilitar la creación de security groups"
  type        = bool
  default     = true
}

variable "create_payment_gateway_role" {
  description = "Crear rol IAM específico para el gateway de pagos"
  type        = bool
  default     = true
}

variable "create_settlement_role" {
  description = "Crear rol IAM específico para el sistema de liquidación"
  type        = bool
  default     = true
}

variable "create_fraud_engine_role" {
  description = "Crear rol IAM específico para el motor antifraude"
  type        = bool
  default     = true
}

variable "payment_gateway_policy" {
  description = "Política personalizada para el gateway de pagos (JSON)"
  type        = string
  default     = ""
}

variable "settlement_policy" {
  description = "Política personalizada para el sistema de liquidación (JSON)"
  type        = string
  default     = ""
}

variable "fraud_engine_policy" {
  description = "Política personalizada para el motor antifraude (JSON)"
  type        = string
  default     = ""
}

variable "security_group_rules" {
  description = "Definición de reglas de security groups personalizada"
  type = object({
    http_port      = number
    https_port     = number
    mysql_port     = number
    postgres_port  = number
    redis_port     = number
    rabbitmq_port  = number
    internal_port  = number
    monitoring_port = number
  })
  default = {
    http_port       = 80
    https_port      = 443
    mysql_port      = 3306
    postgres_port   = 5432
    redis_port      = 6379
    rabbitmq_port   = 5672
    internal_port   = 8080
    monitoring_port = 9090
  }
}

variable "allowed_ingress_ports" {
  description = "Puertos que permiten tráfico entrante desde fuentes externas"
  type        = list(number)
  default     = [443, 22]
}

variable "enable_cloudtrail" {
  description = "Habilitar CloudTrail para auditoría de eventos"
  type        = bool
  default     = true
}

variable "enable_guardduty" {
  description = "Habilitar GuardDuty para detección de amenazas"
  type        = bool
  default     = false
}

variable "enable_security_hub" {
  description = "Habilitar Security Hub para consolidación de hallazgos"
  type        = bool
  default     = false
}

variable "kms_key_administrators" {
  description = "ARNs de usuarios que pueden administrar la clave KMS"
  type        = list(string)
  default     = []
}

variable "kms_key_users" {
  description = "ARNs de usuarios que pueden usar la clave KMS para cifrado/descifrado"
  type        = list(string)
  default     = []
}

variable "enable_secrets_manager" {
  description = "Habilitar Secrets Manager para gestión de credenciales"
  type        = bool
  default     = true
}

variable "secrets_manager_secret_names" {
  description = "Nombres de los secrets a crear en Secrets Manager"
  type        = list(string)
  default     = []
}

variable "enable_waf" {
  description = "Habilitar WAF para protección de aplicaciones web"
  type        = bool
  default     = false
}

variable "waf_web_acl_rules" {
  description = "Configuración de reglas de WAF Web ACL"
  type        = any
  default     = {}
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación en recursos críticos"
  type        = bool
  default     = true
}

// === ARCHIVO: modules/compute/variables.tf ===
# Variables específicas del módulo de cómputo
# Este módulo encapsula la configuración de instancias EC2, Auto Scaling Groups,
# Application Load Balancers y otros recursos de procesamiento

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los recursos de cómputo"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs de subredes públicas para el ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs de subredes privadas para las instancias de aplicación"
  type        = list(string)
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos de cómputo"
  type        = map(string)
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para los servidores de aplicación"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "ID de la AMI personalizada para las instancias"
  type        = string
  default     = ""
}

variable "ami_owner" {
  description = "Propietario de la AMI (aws, self, o account ID)"
  type        = string
  default     = "self"
}

variable "instance_key_name" {
  description = "Nombre del par de claves SSH para acceso a instancias"
  type        = string
  default     = ""
}

variable "min_size" {
  description = "Número mínimo de instancias en el Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Número máximo de instancias en el Auto Scaling Group"
  type        = number
  default     = 10
}

variable "desired_capacity" {
  description = "Número deseado de instancias en el Auto Scaling Group"
  type        = number
  default     = 3
}

variable "target_group_arns" {
  description = "ARNs de los target groups para el ALB"
  type        = list(string)
  default     = []
}

variable "alb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
  default     = ""
}

variable "alb_type" {
  description = "Tipo de ALB: application, network, o gateway"
  type        = string
  default     = "application"
}

variable "alb_internal" {
  description = "Determina si el ALB es interno (true) o público (false)"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación del ALB"
  type        = bool
  default     = true
}

variable "alb_idle_timeout" {
  description = "Tiempo de espera inactivo del ALB en segundos"
  type        = number
  default     = 60
}

variable "enable_cross_zone_load_balancing" {
  description = "Habilitar balanceo de carga entre AZs"
  type        = bool
  default     = true
}

variable "health_check_path" {
  description = "Path para health checks del ALB"
  type        = string
  default     = "/health"
}

variable "health_check_interval" {
  description = "Intervalo entre health checks en segundos"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout de health check en segundos"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Número de respuestas exitosas para considerar instancia saludable"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Número de respuestas fallidas para considerar instancia no saludable"
  type        = number
  default     = 2
}

variable "root_volume_size" {
  description = "Tamaño del volumen raíz en GB"
  type        = number
  default     = 50
}

variable "root_volume_type" {
  description = "Tipo de volumen raíz: gp2, gp3, io1, io2"
  type        = string
  default     = "gp3"
}

variable "root_volume_encrypted" {
  description = "Cifrar volumen raíz"
  type        = bool
  default     = true
}

variable "additional_ebs_volume_size" {
  description = "Tamaño de volumen EBS adicional en GB"
  type        = number
  default     = 0
}

variable "additional_ebs_volume_type" {
  description = "Tipo de volumen EBS adicional"
  type        = string
  default     = "gp3"
}

variable "user_data" {
  description = "Script de inicialización de instancias (base64)"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "Nombre del IAM instance profile para las instancias"
  type        = string
  default     = ""
}

variable "enable_monitoring" {
  description = "Habilitar monitoreo detallado de instancias"
  type        = bool
  default     = true
}

variable "enable_termination_protection" {
  description = "Habilitar protección contra terminación de instancias"
  type        = bool
  default     = false
}

variable "associate_public_ip_address" {
  description = "Asociar IP pública a instancias (solo en subredes públicas)"
  type        = bool
  default     = false
}

variable "placement_tenancy" {
  description = "Tenancy de las instancias: default o dedicated"
  type        = string
  default     = "default"
}

variable "enable_spot_instances" {
  description = "Habilitar uso de instancias spot para reducir costos"
  type        = bool
  default     = false
}

variable "spot_instance_max_price" {
  description = "Precio máximo para instancias spot (en USD por hora)"
  type        = string
  default     = ""
}

variable "asg_metrics" {
  description = "Métricas adicionales a收集 para el ASG"
  type        = list(string)
  default     = []
}

variable "asg_suspended_processes" {
  description = "Procesos suspendidos del ASG"
  type        = list(string)
  default     = []
}

variable "default_cooldown" {
  description = "Cooldown predeterminado del ASG en segundos"
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "Tipo de health check: EC2 o ELB"
  type        = string
  default     = "ELB"
}


// === ARCHIVO: backend.tf ===
terraform {
  backend "s3" {
    bucket = var.backend_bucket
    key    = "${var.environment}/terraform.tfstate"
    region = var.aws_region
    encrypt = true
    dynamodb_table = var.backend_dynamodb_table
  }
}

// === ARCHIVO: main.tf ===
locals {
  common_tags = {
    Environment = var.environment
    Project     = "pagos-seguro"
    ManagedBy   = "terraform"
    Owner       = "cloudops-team"
    CostCenter  = "finanzas"
    Compliance  = "pci-dss"
  }

  vpc_cidr = var.vpc_cidr

  availability_zones = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]

  public_subnet_cidrs = [for i in range(length(local.availability_zones)) : cidrsubnet(local.vpc_cidr, 4, i)]

  private_subnet_app_cidrs = [for i in range(length(local.availability_zones)) : cidrsubnet(local.vpc_cidr, 4, length(local.availability_zones) + i)]

  private_subnet_data_cidrs = [for i in range(length(local.availability_zones)) : cidrsubnet(local.vpc_cidr, 4, 2 * length(local.availability_zones) + i)]

  private_subnet_mgmt_cidrs = [for i in range(length(local.availability_zones)) : cidrsubnet(local.vpc_cidr, 4, 3 * length(local.availability_zones) + i)]
}

module "network" {
  source = "./modules/network"

  environment           = var.environment
  vpc_cidr              = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_app_cidrs  = local.private_subnet_app_cidrs
  private_subnet_data_cidrs = local.private_subnet_data_cidrs
  private_subnet_mgmt_cidrs = local.private_subnet_mgmt_cidrs
  common_tags          = local.common_tags

  nat_gateway_elastic_ips = var.nat_gateway_elastic_ips

  enable_flow_log = true
  flow_log_destination_type = "cloud-watch-logs"
  flow_log_format = "${version} ${account-id} ${interface-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${packets} ${bytes} ${start} ${end} ${action} ${log-status}"
}

module "security" {
  source = "./modules/security"

  environment          = var.environment
  vpc_id               = module.network.vpc_id
  common_tags          = local.common_tags
  allowed_cidr_blocks  = var.admin_cidr_blocks

  enable_guardduty           = var.enable_guardduty
  enable_security_hub        = var.enable_security_hub
  enable_config              = var.enable_config
  enable_cloudtrail          = var.enable_cloudtrail

  security_hub_standards = ["aws-foundational-security-best-standards", "pci-dss"]

  cloudtrail_bucket_name = var.cloudtrail_bucket_name
  cloudtrail_log_prefix  = "audit-logs"

  s3_buckets_to_protect = [
    "pagos-${var.environment}-audit-logs",
    "pagos-${var.environment}-backups",
    "pagos-${var.environment}-application-data"
  ]

  kms_key_administrators = var.kms_administrator_arns
  kms_key_users          = var.kms_user_arns

  enable_deletion_window = true
  deletion_window_days   = 7
}

module "compute" {
  source = "./modules/compute"

  environment              = var.environment
  vpc_id                   = module.network.vpc_id
  common_tags              = local.common_tags

  public_subnet_ids        = module.network.public_subnet_ids
  private_subnet_app_ids   = module.network.private_subnet_app_ids
  private_subnet_data_ids  = module.network.private_subnet_data_ids
  private_subnet_mgmt_ids  = module.network.private_subnet_mgmt_ids

  instance_type            = var.instance_type
  instance_tenancy         = var.instance_tenancy

  key_name                 = var.ssh_key_name

  asg_min_size             = var.asg_min_size
  asg_max_size             = var.asg_max_size
  asg_desired_capacity     = var.asg_desired_capacity

  asg_health_check_type    = "ELB"
  asg_health_check_period  = 60

  asg_metrics_collection   = ["GroupDesiredCapacity", "GroupInServiceCapacity", "GroupPendingCapacity", "GroupTerminatingCapacity", "GroupTotalCapacity"]

  elb_type                 = "application"
  elb_scheme               = "internet-facing"
  elb_deletion_protection  = true
  elb_enable_cross_zone    = true

  elb_access_logs_bucket   = var.elb_access_logs_bucket

  target_instance_port     = 443
  target_instance_protocol = "HTTPS"

  health_check_path        = "/health"
  health_check_interval    = 30
  health_check_timeout     = 5
  healthy_threshold        = 2
  unhealthy_threshold      = 3

  certificate_arn          = var.certificate_arn

  asg_instance_security_groups = [module.security.instance_security_group_id]

  ebs_volume_size          = var.ebs_volume_size
  ebs_volume_type          = "gp3"
  ebs_encrypted            = true

  ebs_kms_key_id           = module.security.ebs_kms_key_arn

  enable_monitoring        = true
  detailed_monitoring      = true

  lifecycle_hook_name      = "instance-termination-hook"
  lifecycle_hook_timeout   = 300

  scaling_policies = [
    {
      name           = "scale-out-policy"
      adjustment_type = "ChangeInCapacity"
      scaling_adjustment = 2
      cooldown       = 300
      metric_type    = "ASGAverageCPUUtilization"
      threshold      = 70
      statistic      = "Average"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 2
      period          = 60
      action_type     = "add"
    },
    {
      name           = "scale-in-policy"
      adjustment_type = "ChangeInCapacity"
      scaling_adjustment = -1
      cooldown       = 300
      metric_type    = "ASGAverageCPUUtilization"
      threshold      = 30
      statistic      = "Average"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = 2
      period          = 60
      action_type     = "remove"
    }
  ]
}

resource "aws_kms_key" "application" {
  description             = "KMS key for application data encryption in ${var.environment}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_application_policy.json

  tags = merge(local.common_tags, {
    Name        = "application-kms-key-${var.environment}"
    Encryption  = "required"
  })
}

data "aws_iam_policy_document" "kms_application_policy" {
  statement {
    sid = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid = "Allow use of the key"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = var.kms_user_arns
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:ListAliases"
    ]
    resources = ["*"]
  }

  statement {
    sid = "Allow key administrators"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = var.kms_administrator_arns
    }
    actions = [
      "kms:Create*",
      "kms:Delete*",
      "kms:Update*",
      "kms:Put*",
      "kms:Revoke*",
      "kms:Enable*",
      "kms:Disable*",
      "kms:List*",
      "kms:Describe*",
      "kms:TagResource",
      "kms:UntagResource"
    ]
    resources = ["*"]
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "application_logs" {
  bucket = "pagos-${var.environment}-application-logs-${data.aws_caller_identity.current.account_id}"

  tags = merge(local.common_tags, {
    Name        = "application-logs-bucket"
    Purpose     = "application-logging"
    Retention   = "90-days"
  })
}

resource "aws_s3_bucket_versioning" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.application.arn
    }
  }
}

resource "aws_s3_bucket_public_access_block" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "application_logs" {
  bucket = aws_s3_bucket.application_logs.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}

resource "aws_cloudwatch_log_group" "application_logs" {
  name              = "/aws/${var.environment}/pagos/application"
  retention_in_days = 90
  kms_key_id        = aws_kms_key.application.arn

  tags = merge(local.common_tags, {
    Name        = "application-log-group"
    Sensitive   = "false"
  })
}

resource "aws_cloudwatch_log_stream" "application_access" {
  name           = "access-logs"
  log_group_name = aws_cloudwatch_log_group.application_logs.name
}

resource "aws_cloudwatch_log_stream" "application_error" {
  name           = "error-logs"
  log_group_name = aws_cloudwatch_log_group.application_logs.name
}

resource "aws_cloudwatch_log_stream" "application_audit" {
  name           = "audit-logs"
  log_group_name = aws_cloudwatch_log_group.application_logs.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
  alarm_name          = "${var.environment}-high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors EC2 CPU utilization"
  alarm_actions       = [module.compute.scale_out_alarm_arn]

  dimensions = {
    AutoScalingGroupName = module.compute.asg_name
  }

  tags = merge(local.common_tags, {
    Name        = "high-cpu-alarm"
    Severity    = "warning"
  })
}

resource "aws_cloudwatch_metric_alarm" "high_memory_utilization" {
  alarm_name          = "${var.environment}-high-memory-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = 60
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "This metric monitors memory utilization"

  dimensions = {
    AutoScalingGroupName = module.compute.asg_name
  }

  tags = merge(local.common_tags, {
    Name        = "high-memory-alarm"
    Severity    = "warning"
  })
}

resource "aws_cloudwatch_metric_alarm" "target_response_time" {
  alarm_name          = "${var.environment}-target-response-time"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "p95"
  threshold           = 1
  alarm_description   = "ALB target response time exceeds threshold"
  alarm_actions       = [module.compute.scale_out_alarm_arn]

  dimensions = {
    LoadBalancer = module.compute.elb_arn
  }

  tags = merge(local.common_tags, {
    Name        = "target-response-time-alarm"
    Severity    = "warning"
    SLI         = "latency"
  })
}

resource "aws_cloudwatch_metric_alarm" "target_5xx_errors" {
  alarm_name          = "${var.environment}-target-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "TargetConnectionErrorCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "ALB target returns 5xx errors"

  dimensions = {
    LoadBalancer = module.compute.elb_arn
  }

  tags = merge(local.common_tags, {
    Name        = "target-5xx-errors-alarm"
    Severity    = "critical"
    SLI         = "availability"
  })
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-s3"
  })
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-dynamodb"
  })
}

resource "aws_vpc_endpoint" "secrets_manager" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.secretsmanager"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-secrets-manager"
  })
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ssm"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-ssm"
  })
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.logs"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-logs"
  })
}

resource "aws_vpc_endpoint" "sqs" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.sqs"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-sqs"
  })
}

resource "aws_vpc_endpoint" "sns" {
  vpc_id       = module.network.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.sns"

  tags = merge(local.common_tags, {
    Name = "vpc-endpoint-sns"
  })
}

// === ARCHIVO: outputs.tf ===
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

// === ARCHIVO: README.md ===
# Diseño de Red Segura para Entorno de Pagos

## Descripción del Proyecto

Este proyecto implementa una topología de red segura y segmentada en AWS para un entorno de pagos de una institución financiera. La arquitectura cumple con los requisitos de alta disponibilidad, throughput de 10.000 transacciones por segundo y SLA del 99.99%.

## Componentes del Sistema

El entorno de pagos está compuesto por tres sistemas principales que requieren segmentación de red:

- **Gateway de Pagos**: Punto de entrada para todas las transacciones de pago. Expone APIs REST para procesamiento de pagos con TLSmutuo.
- **Sistema de Liquidación**: Procesa y concilia las transacciones autorizadas. Requiere acceso a bases de datos sensibles y comunicación cifrada.
- **Motor Antifraude**: Analiza transacciones en tiempo real utilizando modelos de ML. Necesita conectividad con servicios de terceros y almacenamiento de patrones.

## Topología de Red

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              VPC PRINCIPAL (10.0.0.0/16)                    │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         ZONA DE DISPONIBILIDAD A                    │   │
│  │  ┌─────────────────┐    ┌─────────────────┐    ┌────────────────┐  │   │
│  │  │  Subred Pública │    │ Subred Privada  │    │ Subred Privada │  │   │
│  │  │   (App Tier)    │    │  (Data Tier)    │    │ (Security Tier)│  │   │
│  │  │  10.0.1.0/24    │    │  10.0.2.0/24    │    │  10.0.3.0/24   │  │   │
│  │  │                  │    │                  │    │                │  │   │
│  │  │  ┌────────────┐  │    │  ┌────────────┐  │    │  ┌──────────┐  │  │   │
│  │  │  │   ALB/NLB │  │    │  │   RDS/Aurora│ │    │  │  EC2     │  │  │   │
│  │  │  │  (Pagos)  │  │    │  │ (Liquidac.) │ │    │  │(Antifraude)│ │  │   │
│  │  │  └────────────┘  │    │  └────────────┘  │    │  └──────────┘  │  │   │
│  │  └─────────────────┘    └─────────────────┘    └────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         ZONA DE DISPONIBILIDAD B                    │   │
│  │  ┌─────────────────┐    ┌─────────────────┐    ┌────────────────┐  │   │
│  │  │  Subred Pública │    │ Subred Privada  │    │ Subred Privada │  │   │
│  │  │   (App Tier)    │    │  (Data Tier)    │    │ (Security Tier)│  │   │
│  │  │  10.0.11.0/24   │    │  10.0.12.0/24   │    │  10.0.13.0/24  │  │   │
│  │  │                  │    │                  │    │                │  │   │
│  │  │  ┌────────────┐  │    │  ┌────────────┐  │    │  ┌──────────┐  │  │   │
│  │  │  │   ALB/NLB │  │    │  │   RDS/Aurora│ │    │  │  EC2     │  │  │   │
│  │  │  │  (Pagos)  │  │    │  │ (Liquidac.) │ │    │  │(Antifraude)│ │  │   │
│  │  │  └────────────┘  │    │  └────────────┘  │    │  └──────────┘  │  │   │
│  │  └─────────────────┘    └─────────────────┘    └────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                        GATEWAY DE INTERNET                          │   │
│  │  ┌──────────────────────────────────────────────────────────────┐  │   │
│  │  │                    Internet Gateway                          │  │   │
│  │  │               + NAT Gateways (HA)                            │  │   │
│  │  └──────────────────────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘

Segmentación de Tráfico:
- Subredes Públicas: ALB/NLB expuestos a Internet con WAF
- Subredes Privadas App: EC2 con aplicaciones de procesamiento
- Subredes Privadas Data: RDS PostgreSQL/Aurora con cifrado
- Subredes Privadas Security: Motor antifraude con acceso controlado
```

## Estructura de Módulos

### Módulo Network

El módulo de red gestiona toda la infraestructura de conectividad:

- **VPC Principal**: CIDR 10.0.0.0/16 con soporte para múltiples AZs
- **Subredes Públicas**: 10.0.1.0/24 y 10.0.11.0/24 para componentes expuestos
- **Subredes Privadas App**: 10.0.2.0/24 y 10.0.12.0/24 para aplicaciones
- **Subredes Privadas Data**: 10.0.3.0/24 y 10.0.13.0/24 para bases de datos
- **Internet Gateway**: Conexión bidireccional con Internet
- **NAT Gateways**: Alta disponibilidad en cada AZ para salida de tráfico
- **Tablas de Rutas**: Segmentación específica por tipo de subred
- **Network ACLs**: Reglas stateless para control de tráfico entre subredes

### Módulo Security

El módulo de seguridad implementa el principio de menor privilegio:

- **IAM Roles**: Roles específicos por servicio con políticas inline
- **Security Groups**: Grupos de seguridad por componente con reglas mínimas
- **KMS Keys**: Claves de cifrado para datos en reposo
- **CloudWatch Logs**: Retención configurable de logs de auditoría
- **IAM Policies**: Políticas documentadas con permisos explícitos

### Módulo Compute

El módulo de compute gestiona los recursos de procesamiento:

- **ALB/NLB**: Balanceadores de carga con terminate TLS y health checks
- **EC2 Instances**: Instancias auto-escalables para aplicaciones
- **Auto Scaling Groups**: Configuración de escalamiento basado en métricas
- **Target Groups**: Grupos de destino con health checks configurables

## Uso del Proyecto

### Requisitos Previos

- Terraform >= 1.5 instalado
- AWS CLI configurado con credenciales apropiadas
- Acceso a cuenta de AWS con permisos para crear recursos

### Inicialización

```bash
# Inicializar Terraform sin backend para validación
terraform init -backend=false

# Validar la configuración
terraform validate

# Verificar formato de archivos
terraform fmt -check

# Planificar cambios para un ambiente específico
cd environments/dev
terraform plan
```

### Ambientes Disponibles

El proyecto soporta tres ambientes con configuración específica:

- **dev**: Configuración de desarrollo con recursos de menor tamaño
- **qa**: Configuración de pruebas con recursos equivalentes a producción
- **prod**: Configuración de producción con alta disponibilidad completa

### Despliegue por Ambiente

```bash
# Desarrollo
cd environments/dev
terraform init -backend-config=../backend.tf
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars

# Producción
cd environments/prod
terraform init -backend-config=../backend.tf
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

## Consideraciones de Seguridad

### Cifrado

- Datos en reposo: Cifrado con AWS KMS en todas las opciones de almacenamiento
- Datos en tránsito: TLS 1.2 mínimo para todas las comunicaciones
- Secrets: Almacenamiento en AWS Secrets Manager con rotación automática

### Segmentación de Red

- Las subredes públicas solo contienen ALB/NLB con reglas de entrada limitadas
- Las subredes privadas no tienen rutas directas a Internet
- El tráfico entre subredes está controlado por NACLs y Security Groups
- El tráfico east-west está restringido entre segmentos de confianza

### Identidades y Accesos

- Cada servicio tiene un rol IAM específico con permisos mínimos necesarios
- No se utilizan credenciales hardcodeadas ni ARNs estáticos
- MFA requerido para operaciones sensibles
- CloudTrail registra todas las operaciones con retención de 90 días

## Monitoreo y Observabilidad

### Métricas de Red

- Latencia entre AZs: Objetivo < 1ms
- Throughput: Capacidad para 10.000 TPS
- Disponibilidad: SLA 99.99% (máximo 52 minutos de downtime anual)

### Alarmas Configuradas

- CPU Utilization > 80% por 5 minutos
- NetworkIn/NetworkOut fuera de rangos esperados
- Health check failures en ALB
- Latencia de respuesta > 2 segundos

### Logging

- VPC Flow Logs para análisis de tráfico de red
- CloudWatch Logs para aplicaciones con retención de 30 días
- CloudTrail para auditoría de cambios en infraestructura

## Optimización de Costos

### Estrategias Aplicadas

- Reserved Instances para cargas base conocidas
- Spot Instances para workloads tolerantes a interrupciones
- Lifecycle policies en S3 para transición automática a Glacier
- Tags obligatorios en todos los recursos para tracking de costos

### Tags Requeridos

Todos los recursos incluyen los siguientes tags:

- Environment: dev | qa | prod
- Project: payments-network
- CostCenter: centro-de-costo-configurado
- Owner: equipo-responsable
- Compliance: nivel-de-cumplimiento

## Gobernanza y Cumplimiento

### Controles Implementados

- AWS Config Rules para validación de recursos conformes
- SCPs (Service Control Policies) a nivel de cuenta
- AWS GuardDuty para detección de amenazas
- AWS Security Hub para consolidacion de hallazgos

### Frameworks de Referencia

La arquitectura cumple con principios de:

- PCI-DSS para entornos de pago
- AWS Well-Architected Framework
- NIST 800-53 para controles de seguridad

## Mantenimiento y Operaciones

### Procedimientos de Cambio

1. Los cambios se realizan en branches dedicados
2. Pull request requiere revisión de infraestructura
3. Plan de Terraform se revisa antes de merge
4. Apply se ejecuta en ventana de mantenimiento
5. Rollback procedure documentado para cada cambio

### Recuperación ante Desastres

- RTO (Recovery Time Objective): 4 horas
- RPO (Recovery Point Objective): 15 minutos
- Réplicas cruzadas en múltiples AZs
- Backups automatizados con restauración probada

## Contacto y Soporte

Para cuestiones sobre esta implementación:

- Equipo de Cloud Infrastructure: cloud-infra@empresa.com
- Seguridad de la Información: security@empresa.com
- Equipo de Platform Engineering: platform@empresa.com


// === ARCHIVO: environments/dev/terraform.tfvars ===
# Configuración de desarrollo - Environment de desarrollo para pruebas iniciales
# Settings: Desarrollo temprano, menor escala, costos optimizados

environment = "dev"
environment_short = "d"

# Configuración de la VPC
vpc_cidr = "10.100.0.0/16"
vpc_name = "pagos-dev-vpc"
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de Availability Zones (dev usa 2 AZs para reducir costos)
availability_zones = ["us-east-1a", "us-east-1b"]

# Subredes públicas - Para ALB, NAT Gateway, servicios que necesitan internet pública
public_subnet_cidrs = ["10.100.1.0/24", "10.100.2.0/24"]
public_subnet_names = ["pagos-dev-pub-us-east-1a", "pagos-dev-pub-us-east-1b"]
map_public_ip_on_launch = true

# Subredes privadas para aplicaciones - Backend de la aplicación
app_subnet_cidrs = ["10.100.10.0/24", "10.100.11.0/24"]
app_subnet_names = ["pagos-dev-priv-app-us-east-1a", "pagos-dev-priv-app-us-east-1b"]

# Subredes privadas para datos - Databases y sistemas de almacenamiento
data_subnet_cidrs = ["10.100.20.0/24", "10.100.21.0/24"]
data_subnet_names = ["pagos-dev-priv-data-us-east-1a", "pagos-dev-priv-data-us-east-1b"]

# Subredes privadas para servicios de pago - Gateway de pagos, liquidación, antifraude
payment_subnet_cidrs = ["10.100.30.0/24", "10.100.31.0/24"]
payment_subnet_names = ["pagos-dev-priv-payment-us-east-1a", "pagos-dev-priv-payment-us-east-1b"]

# Configuración de NAT Gateway (alta disponibilidad en producción, mínimo en dev)
nat_gateway_count = 1
nat_gateway_type = "single"

# Configuración de Internet Gateway
enable_internet_gateway = true

# Configuración de VPN/Direct Connect (no necesario en dev)
enable_vpn_gateway = false

# Configuración de seguridad - Grupos de seguridad
# ALB público - Expuesto a internet para pruebas
alb_security_group_name = "pagos-dev-alb-public-sg"
alb_port = 443
alb_protocol = "HTTPS"

# Security group para aplicación
app_security_group_name = "pagos-dev-app-sg"
app_allow_ports = [443, 8080]
app_protocol = "tcp"

# Security group para base de datos
database_security_group_name = "pagos-dev-db-sg"
db_port = 5432
db_protocol = "tcp"
db_allow_cidrs = ["10.100.10.0/24", "10.100.30.0/24"]

# Security group para servicios de pago
payment_security_group_name = "pagos-dev-payment-sg"
payment_port = 8443
payment_protocol = "tcp"
payment_allow_cidrs = ["10.100.10.0/24"]

# Configuración de IAM - Roles con menor privilegio
# Rol para EC2 de aplicación
app_iam_role_name = "pagos-dev-app-ec2-role"
app_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "s3:ListBucket",
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "cloudwatch:PutMetricData",
  "logs:CreateLogGroup",
  "logs:PutLogEvents"
]

# Rol para servicios de pago
payment_iam_role_name = "pagos-dev-payment-role"
payment_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:GenerateDataKey",
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query"
]

# Configuración de logging y monitoreo
enable_vpc_flow_logs = true
flow_log_destination_type = "cloud-watch-logs"
log_retention_days = 7

# Alarmas CloudWatch - Configuración básica para dev
enable_alarms = true
alarm_cpu_threshold = 80
alarm_memory_threshold = 85
alarm_http_5xx_threshold = 5

# Configuración de alta disponibilidad
# Dev usa menor redundancia para optimizar costos
multi_az = false
instance_tenancy = "default"

# Configuración de escalado (dev usa configuración básica)
asg_min_size = 1
asg_max_size = 2
asg_desired_capacity = 1
asg_health_check_type = "ELB"
asg_health_check_grace_period = 300

# Configuración de almacenamiento
root_volume_size = 30
root_volume_type = "gp3"
data_volume_size = 100
data_volume_type = "gp3"

# Configuración de red avanzada
enable_transit_gateway = false
enable_private_link = false

# Tags obligatorios para todos los recursos
common_tags = {
  Environment = "development"
  Project = "pagos-seguro"
  CostCenter = "it-operations"
  Compliance = "pci-dss"
  ManagedBy = "terraform"
  Owner = "cloudops-team"
}

// === ARCHIVO: environments/qa/terraform.tfvars ===
# Configuración de QA - Environment de pruebas de integración y QA
# Settings: Pruebas funcionales, mayor escala que dev, validación de seguridad

environment = "qa"
environment_short = "q"

# Configuración de la VPC
vpc_cidr = "10.101.0.0/16"
vpc_name = "pagos-qa-vpc"
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de Availability Zones (QA usa 2 AZs para balance costo/rendimiento)
availability_zones = ["us-east-1a", "us-east-1b"]

# Subredes públicas
public_subnet_cidrs = ["10.101.1.0/24", "10.101.2.0/24"]
public_subnet_names = ["pagos-qa-pub-us-east-1a", "pagos-qa-pub-us-east-1b"]
map_public_ip_on_launch = true

# Subredes privadas para aplicaciones
app_subnet_cidrs = ["10.101.10.0/24", "10.101.11.0/24"]
app_subnet_names = ["pagos-qa-priv-app-us-east-1a", "pagos-qa-priv-app-us-east-1b"]

# Subredes privadas para datos
data_subnet_cidrs = ["10.101.20.0/24", "10.101.21.0/24"]
data_subnet_names = ["pagos-qa-priv-data-us-east-1a", "pagos-qa-priv-data-us-east-1b"]

# Subredes privadas para servicios de pago - Mayor segmentación en QA
payment_subnet_cidrs = ["10.101.30.0/24", "10.101.31.0/24"]
payment_subnet_names = ["pagos-qa-priv-payment-us-east-1a", "pagos-qa-priv-payment-us-east-1b"]

# Subred dedicada para motor antifraude
fraud_subnet_cidrs = ["10.101.40.0/24", "10.101.41.0/24"]
fraud_subnet_names = ["pagos-qa-priv-fraud-us-east-1a", "pagos-qa-priv-fraud-us-east-1b"]

# NAT Gateway - Alta disponibilidad en QA
nat_gateway_count = 2
nat_gateway_type = "redundant"

# Internet Gateway
enable_internet_gateway = true

# VPN para acceso seguro a QA
enable_vpn_gateway = true
vpn_connection_type = "ipsec.1"

# Security Groups
alb_security_group_name = "pagos-qa-alb-public-sg"
alb_port = 443
alb_protocol = "HTTPS"
alb_ssl_policy = "ELBSecurityPolicy-2016-08"

app_security_group_name = "pagos-qa-app-sg"
app_allow_ports = [443, 8080, 8443]
app_protocol = "tcp"

database_security_group_name = "pagos-qa-db-sg"
db_port = 5432
db_protocol = "tcp"
db_allow_cidrs = ["10.101.10.0/24", "10.101.30.0/24", "10.101.40.0/24"]

payment_security_group_name = "pagos-qa-payment-sg"
payment_port = 8443
payment_protocol = "tcp"
payment_allow_cidrs = ["10.101.10.0/24"]

fraud_security_group_name = "pagos-qa-fraud-sg"
fraud_port = 8080
fraud_protocol = "tcp"
fraud_allow_cidrs = ["10.101.10.0/24", "10.101.30.0/24"]

# IAM - Políticas más restrictivas en QA simulando producción
app_iam_role_name = "pagos-qa-app-ec2-role"
app_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "s3:ListBucket",
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "cloudwatch:PutMetricData",
  "logs:CreateLogGroup",
  "logs:PutLogEvents",
  "secretsmanager:GetSecretValue"
]
app_iam_resource_restrictions = true

payment_iam_role_name = "pagos-qa-payment-role"
payment_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:GenerateDataKey",
  "kms:DescribeKey",
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "dynamodb:BatchGetItem",
  "dynamodb:BatchWriteItem"
]
payment_iam_resource_restrictions = true

fraud_iam_role_name = "pagos-qa-fraud-role"
fraud_iam_policy_actions = [
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "dynamodb:Scan",
  "s3:GetObject",
  "s3:PutObject",
  "kinesis:GetRecords",
  "kinesis:GetShardIterator",
  "kinesis:DescribeStream"
]

# Configuración de logging - Mayor retención en QA
enable_vpc_flow_logs = true
flow_log_destination_type = "cloud-watch-logs"
log_retention_days = 30
log_file_format = "parquet"

# Alarmas CloudWatch - Configuración completa para QA
enable_alarms = true
alarm_cpu_threshold = 75
alarm_memory_threshold = 80
alarm_http_5xx_threshold = 3
alarm_latency_p95_threshold = 500
alarm_retry_count_threshold = 3
alarm_sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:pagos-qa-alarms"

# Alta disponibilidad en QA
multi_az = true
instance_tenancy = "default"

# Auto Scaling Group - Configuración de producción ligera
asg_min_size = 2
asg_max_size = 4
asg_desired_capacity = 2
asg_health_check_type = "ELB"
asg_health_check_grace_period = 300
asg_cooldown_period = 300
asg_scale_up_threshold = 70
asg_scale_down_threshold = 30

# Almacenamiento
root_volume_size = 50
root_volume_type = "gp3"
data_volume_size = 200
data_volume_type = "gp3"
enable_ebs_encryption = true

# Configuración de red avanzada - Preparado para PrivateLink
enable_transit_gateway = false
enable_private_link = true
endpoints = [
  "s3",
  "dynamodb",
  "secretsmanager",
  "sqs",
  "sns"
]

# Tags
common_tags = {
  Environment = "qa"
  Project = "pagos-seguro"
  CostCenter = "it-operations"
  Compliance = "pci-dss"
  ManagedBy = "terraform"
  Owner = "cloudops-team"
  QAValidation = "required"
}

// === ARCHIVO: environments/prod/terraform.tfvars ===
# Configuración de Producción - Environment de producción para sistema de pagos
# Settings: Alta disponibilidad, máximo rendimiento, cumplimiento PCI-DSS

environment = "prod"
environment_short = "p"

# Configuración de la VPC
vpc_cidr = "10.102.0.0/16"
vpc_name = "pagos-prod-vpc"
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de Availability Zones - 3 AZs para máxima disponibilidad
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Subredes públicas - Distribuidas en 3 AZs
public_subnet_cidrs = ["10.102.1.0/24", "10.102.2.0/24", "10.102.3.0/24"]
public_subnet_names = ["pagos-prod-pub-us-east-1a", "pagos-prod-pub-us-east-1b", "pagos-prod-pub-us-east-1c"]
map_public_ip_on_launch = true

# Subredes privadas para aplicaciones - 3 AZs
app_subnet_cidrs = ["10.102.10.0/24", "10.102.11.0/24", "10.102.12.0/24"]
app_subnet_names = ["pagos-prod-priv-app-us-east-1a", "pagos-prod-priv-app-us-east-1b", "pagos-prod-priv-app-us-east-1c"]

# Subredes privadas para datos - 3 AZs con replicación
data_subnet_cidrs = ["10.102.20.0/24", "10.102.21.0/24", "10.102.22.0/24"]
data_subnet_names = ["pagos-prod-priv-data-us-east-1a", "pagos-prod-priv-data-us-east-1b", "pagos-prod-priv-data-us-east-1c"]

# Subredes privadas para servicios de pago - Aislamiento total
payment_subnet_cidrs = ["10.102.30.0/24", "10.102.31.0/24", "10.102.32.0/24"]
payment_subnet_names = ["pagos-prod-priv-payment-us-east-1a", "pagos-prod-priv-payment-us-east-1b", "pagos-prod-priv-payment-us-east-1c"]

# Subred dedicada para motor antifraude - Procesamiento crítico
fraud_subnet_cidrs = ["10.102.40.0/24", "10.102.41.0/24", "10.102.42.0/24"]
fraud_subnet_names = ["pagos-prod-priv-fraud-us-east-1a", "pagos-prod-priv-fraud-us-east-1b", "pagos-prod-priv-fraud-us-east-1c"]

# Subred para sistema de liquidación
settlement_subnet_cidrs = ["10.102.50.0/24", "10.102.51.0/24", "10.102.52.0/24"]
settlement_subnet_names = ["pagos-prod-priv-settlement-us-east-1a", "pagos-prod-priv-settlement-us-east-1b", "pagos-prod-priv-settlement-us-east-1c"]

# NAT Gateway - Alta disponibilidad con redundancia completa
nat_gateway_count = 3
nat_gateway_type = "redundant-one-per-az"
nat_eip_allocation = true

# Internet Gateway -冗余配置
enable_internet_gateway = true
igw_redundant = true

# VPN y Direct Connect para conectividad híbrida
enable_vpn_gateway = true
vpn_connection_type = "ipsec.1"
vpn_tunnel_options = {
  tunnel1 = { encryption = "AES256", integrity = "SHA256", pre_shared_key = "dynamic" }
  tunnel2 = { encryption = "AES256", integrity = "SHA256", pre_shared_key = "dynamic" }
}
enable_direct_connect = true
direct_connect_location = "eqdc"

# Security Groups - Máxima restricción
alb_security_group_name = "pagos-prod-alb-public-sg"
alb_port = 443
alb_protocol = "HTTPS"
alb_ssl_policy = "ELBSecurityPolicy-TLS-1-2-2021-07"
alb_access_logging = true
alb_deletion_protection = true

app_security_group_name = "pagos-prod-app-sg"
app_allow_ports = [443, 8443]
app_protocol = "tcp"
app_allow_from_security_groups = ["pagos-prod-alb-public-sg"]
app_intra_vpc_restricted = true

database_security_group_name = "pagos-prod-db-sg"
db_port = 5432
db_protocol = "tcp"
db_allow_cidrs = []
db_allow_from_security_groups = ["pagos-prod-app-sg", "pagos-prod-payment-sg", "pagos-prod-fraud-sg"]
db_encryption_enabled = true
db_audit_logging = true

payment_security_group_name = "pagos-prod-payment-sg"
payment_port = 8443
payment_protocol = "tcp"
payment_allow_cidrs = ["10.102.10.0/24"]
payment_allow_from_security_groups = ["pagos-prod-app-sg"]
payment_strict_mode = true

fraud_security_group_name = "pagos-prod-fraud-sg"
fraud_port = 8080
fraud_protocol = "tcp"
fraud_allow_cidrs = ["10.102.10.0/24", "10.102.30.0/24"]
fraud_allow_from_security_groups = ["pagos-prod-app-sg", "pagos-prod-payment-sg"]

settlement_security_group_name = "pagos-prod-settlement-sg"
settlement_port = 8080
settlement_protocol = "tcp"
settlement_allow_from_security_groups = ["pagos-prod-payment-sg"]

# IAM - Principio de menor privilegio estricto con permisos específicos por recurso
app_iam_role_name = "pagos-prod-app-ec2-role"
app_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject"
]
app_iam_resource_arns = [
  "arn:aws:s3:::pagos-prod-data/*",
  "arn:aws:s3:::pagos-prod-data",
  "arn:aws:dynamodb:us-east-1:123456789012:table/pagos-prod-transactions"
]
app_iam_condition_keys = ["aws:RequestedRegion", "aws:PrincipalAccount"]

payment_iam_role_name = "pagos-prod-payment-role"
payment_iam_policy_actions = [
  "s3:GetObject",
  "s3:PutObject",
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:GenerateDataKey*"
]
payment_iam_resource_arns = [
  "arn:aws:s3:::pagos-prod-pci/*",
  "arn:aws:s3:::pagos-prod-pci",
  "arn:aws:kms:us-east-1:123456789012:key/pagos-prod-master-key",
  "arn:aws:dynamodb:us-east-1:123456789012:table/pagos-prod-sensitive"
]
payment_iam_condition_keys = ["aws:RequestedRegion", "aws:PrincipalAccount", "aws:PrincipalTag/Department"]

fraud_iam_role_name = "pagos-prod-fraud-role"
fraud_iam_policy_actions = [
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "kinesis:GetRecords*"
]
fraud_iam_resource_arns = [
  "arn:aws:dynamodb:us-east-1:123456789012:table/pagos-prod-fraud*",
  "arn:aws:kinesis:us-east-1:123456789012:stream/pagos-prod-fraud-stream"
]

settlement_iam_role_name = "pagos-prod-settlement-role"
settlement_iam_policy_actions = [
  "dynamodb:GetItem",
  "dynamodb:PutItem",
  "dynamodb:Query",
  "s3:GetObject",
  "s3:PutObject",
  "sqs:ReceiveMessage",
  "sqs:DeleteMessage"
]
settlement_iam_resource_arns = [
  "arn:aws:dynamodb:us-east-1:123456789012:table/pagos-prod-settlement*",
  "arn:aws:s3:::pagos-prod-settlement/*",
  "arn:aws:sqs:us-east-1:123456789012:pagos-prod-settlement-queue"
]

# Configuración de logging - Completa con auditoría
enable_vpc_flow_logs = true
flow_log_destination_type = "cloud-watch-logs"
log_retention_days = 90
log_file_format = "parquet"
log_compression = "gzip"
flow_log_max_aggregation_interval = 60

# CloudWatch - Monitoreo completo con métricas personalizadas
enable_alarms = true
alarm_cpu_threshold = 70
alarm_memory_threshold = 75
alarm_http_5xx_threshold = 1
alarm_http_4xx_threshold = 10
alarm_latency_p95_threshold = 200
alarm_latency_p99_threshold = 500
alarm_retry_count_threshold = 2
alarm_queue_depth_threshold = 1000
alarm_connection_errors_threshold = 5
alarm_sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:pagos-prod-alarms"
alarm_escalation_policy = "pagos-oncall"

# Alta disponibilidad - Configuración completa
multi_az = true
instance_tenancy = "dedicated"
enable_aurora_multi_az = true
rds_backup_retention_days = 30
rds_delete_protection = true

# Auto Scaling - Configuración dinámica
asg_min_size = 3
asg_max_size = 10
asg_desired_capacity = 5
asg_health_check_type = "ELB"
asg_health_check_grace_period = 120
asg_cooldown_period = 180
asg_scale_up_threshold = 60
asg_scale_down_threshold = 25
asg_predictive_scaling = true
asg_target_value = 70

# Almacenamiento - Cifrado y rendimiento
root_volume_size = 80
root_volume_type = "gp3"
root_volume_iops = 3000
data_volume_size = 500
data_volume_type = "gp3"
data_volume_iops = 10000
enable_ebs_encryption = true
kms_key_id = "alias/pagos-prod-ebs"

# Configuración de red avanzada - Transit Gateway y PrivateLink
enable_transit_gateway = true
transit_gateway_asn = 64512
transit_gateway_route_tables = {
  spoke = "pagos-prod-spoke-rt"
  shared = "pagos-prod-shared-rt"
}
enable_private_link = true
endpoints = [
  "s3",
  "dynamodb",
  "secretsmanager",
  "sqs",
  "sns",
  "kms",
  "cloudwatch",
  "logs"
]

# DDoS y WAF
enable_shield_advanced = true
enable_waf = true
waf_rules = [
  "AWSManagedRulesCommonRuleSet",
  "AWSManagedRulesSQLiRuleSet",
  "AWSManagedRulesKnownBadInputsRuleSet"
]
waf_rate_limit = 1000

# Backup y recuperación
enable_backup = true
backup_plan = "pagos-prod-daily"
backup_copies = 3
backup_cold_storage = true
backup_retention_days = 2555

# Tags - Cumplimiento PCI-DSS
common_tags = {
  Environment = "production"
  Project = "pagos-seguro"
  CostCenter = "it-operations"
  Compliance = "pci-dss"
  ManagedBy = "terraform"
  Owner = "cloudops-team"
  DataClassification = "confidential"
  BackupRequired = "true"
  DRTier = "1"
  RTO = "15m"
  RPO = "5m"
}


// === ARCHIVO: modules/network/main.tf ===
# Módulo de red: define la topología de VPC, subredes, gateways y tablas de rutas
# Segmentación de red para entorno de pagos con alta disponibilidad

# VPC principal del entorno de pagos
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
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
  map_public_ip_on_launch = true
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

// === ARCHIVO: modules/network/outputs.tf ===
# Outputs del módulo de red: exposición de IDs y ARNs para consumo por otros módulos

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways por zona de disponibilidad"
  value       = aws_nat_gateway.main[*].id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "IDs de las subredes de base de datos"
  value       = aws_subnet.database[*].id
}

output "database_subnet_group_id" {
  description = "ID del grupo de subredes de base de datos"
  value       = aws_subnet_group.database.id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas por AZ"
  value       = aws_route_table.private[*].id
}

output "public_subnet_cidrs" {
  description = "Bloques CIDR de las subredes públicas"
  value       = var.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "Bloques CIDR de las subredes privadas"
  value       = var.private_subnet_cidrs
}

output "database_subnet_cidrs" {
  description = "Bloques CIDR de las subredes de base de datos"
  value       = var.database_subnet_cidrs
}

output "availability_zones" {
  description = "Zonas de disponibilidad configuradas"
  value       = var.availability_zones
}

// === ARCHIVO: modules/security/main.tf ===
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

# Regla de entrada: HTTPS desde cualquier lugar
resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Permitir HTTPS desde internet"
}

# Regla de entrada: HTTP desde cualquier lugar
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Permitir HTTP desde internet"
}

# Regla de salida: todo el tráfico hacia VPC
resource "aws_vpc_security_group_ingress_rule" "alb_to_internal" {
  security_group_id            = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.app.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  description                  = "Permitir tráfico al grupo de aplicaciones"
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

# Regla de entrada: solo desde ALB
resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = 8443
  to_port                      = 8443
  ip_protocol                  = "tcp"
  description                  = "Permitir tráfico del ALB"
}

# Regla de entrada: SSH desde bastion (si existe)
resource "aws_vpc_security_group_ingress_rule" "app_from_bastion" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.bastion.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  description                  = "Permitir SSH desde bastion"
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

# Regla de entrada: MySQL/PostgreSQL solo desde grupo de aplicación
resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id            = aws_security_group.database.id
  referenced_security_group_id = aws_security_group.app.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  description                  = "Permitir MySQL desde aplicaciones"
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

# Regla entrante NACL privada: solo desde subredes públicas (ALB)
resource "aws_network_acl_rule" "private_app_in" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  from_port      = 8443
  to_port        = 8443
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


// === ARCHIVO: modules/security/outputs.tf ===
output "web_security_group_id" {
  description = "ID del grupo de seguridad para la capa web pública"
  value       = aws_security_group.web_sg.id
}

output "app_security_group_id" {
  description = "ID del grupo de seguridad para la capa de aplicación"
  value       = aws_security_group.app_sg.id
}

output "db_security_group_id" {
  description = "ID del grupo de seguridad para la base de datos"
  value       = aws_security_group.db_sg.id
}

output "internal_alb_security_group_id" {
  description = "ID del grupo de seguridad para el ALB interno"
  value       = aws_security_group.internal_alb_sg.id
}

output "payment_gateway_role_arn" {
  description = "ARN del rol IAM para el gateway de pagos"
  value       = aws_iam_role.payment_gateway_role.arn
}

output "settlement_role_arn" {
  description = "ARN del rol IAM para el sistema de liquidación"
  value       = aws_iam_role.settlement_role.arn
}

output "fraud_detection_role_arn" {
  description = "ARN del rol IAM para el motor antifraude"
  value       = aws_iam_role.fraud_detection_role.arn
}

output "ec2_instance_profile_name" {
  description = "Nombre del perfil de instancia EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "lambda_execution_role_arn" {
  description = "ARN del rol de ejecución para funciones Lambda"
  value       = aws_iam_role.lambda_execution_role.arn
}

output "payment_gateway_policy_arn" {
  description = "ARN de la política para el gateway de pagos"
  value       = aws_iam_policy.payment_gateway_policy.arn
}

output "settlement_policy_arn" {
  description = "ARN de la política para el sistema de liquidación"
  value       = aws_iam_policy.settlement_policy.arn
}

output "fraud_detection_policy_arn" {
  description = "ARN de la política para el motor antifraude"
  value       = aws_iam_policy.fraud_detection_policy.arn
}

output "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado de datos sensibles"
  value       = aws_kms_key.payment_key.arn
}

output "secrets_manager_secret_arn" {
  description = "ARN del secreto en Secrets Manager para credenciales de pagos"
  value       = aws_secretsmanager_secret.payment_credentials.arn
}

output "web_security_group_arn" {
  description = "ARN del grupo de seguridad web para referencia cruzada"
  value       = aws_security_group.web_sg.arn
}

output "app_security_group_arn" {
  description = "ARN del grupo de seguridad de aplicación"
  value       = aws_security_group.app_sg.arn
}

output "db_security_group_arn" {
  description = "ARN del grupo de seguridad de base de datos"
  value       = aws_security_group.db_sg.arn
}

output "vpc_endpoint_s3_id" {
  description = "ID del endpoint de VPC para S3"
  value       = aws_vpc_endpoint.s3_endpoint.id
}

output "vpc_endpoint_secretsmanager_id" {
  description = "ID del endpoint de VPC para Secrets Manager"
  value       = aws_vpc_endpoint.secretsmanager_endpoint.id
}

output "all_security_group_ids" {
  description = "Mapa con todos los IDs de grupos de seguridad"
  value       = {
    web          = aws_security_group.web_sg.id
    app          = aws_security_group.app_sg.id
    db           = aws_security_group.db_sg.id
    internal_alb = aws_security_group.internal_alb_sg.id
  }
}

output "all_iam_role_arns" {
  description = "Mapa con todos los ARNs de roles IAM"
  value       = {
    payment_gateway   = aws_iam_role.payment_gateway_role.arn
    settlement        = aws_iam_role.settlement_role.arn
    fraud_detection   = aws_iam_role.fraud_detection_role.arn
    lambda_execution  = aws_iam_role.lambda_execution_role.arn
  }
}
// === ARCHIVO: modules/compute/main.tf ===
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_subnets" "private_app_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Type"
    values = ["private-app"]
  }
}

data "aws_subnets" "public_web_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Type"
    values = ["public-web"]
  }
}

resource "aws_launch_template" "payment_gateway_lt" {
  name_prefix   = "payment-gateway-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.payment_gateway_instance_type

  iam_instance_profile {
    arn = var.ec2_instance_profile_arn
  }

  vpc_security_group_ids = [var.web_security_group_id, var.app_security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker nginx
              systemctl enable docker
              systemctl start docker
              docker run -d --name payment-gateway -p 8080:8080 \
                -e DB_HOST=${var.db_endpoint} \
                -e FRAUD_DETECTION_ENDPOINT=${var.fraud_detection_endpoint} \
                -e SETTLEMENT_ENDPOINT=${var.settlement_endpoint} \
                payment-gateway:latest
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

resource "aws_instance" "settlement_service" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.settlement_instance_type
  subnet_id     = data.aws_subnets.private_app_subnets.ids[0]

  iam_instance_profile = var.ec2_instance_profile_name

  vpc_security_group_ids = [var.app_security_group_id, var.db_security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y java-17-openjdk postgresql15-client
              useradd -m -s /bin/bash settlement
              mkdir -p /opt/settlement
              cd /opt/settlement
              wget -q https://settlement-service-bucket.s3.amazonaws.com/settlement-service.jar
              chown -R settlement:settlement /opt/settlement
              su - settlement -c "java -jar /opt/settlement/settlement-service.jar \
                --spring.datasource.url=jdbc:postgresql://${var.db_endpoint}/settlement \
                --server.port=8081"
              EOF
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
  }

  monitoring = true

  tags = {
    Name        = "settlement-service"
    Environment = var.environment
    Component   = "settlement"
    Tier        = "application"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "payment_gateway_asg" {
  name                = "payment-gateway-asg-${var.environment}"
  vpc_zone_identifier = data.aws_subnets.private_app_subnets.ids
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

resource "aws_lb" "public_alb" {
  name               = "payment-gateway-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_security_group_id]
  subnets            = data.aws_subnets.public_web_subnets.ids

  enable_deletion_protection = var.environment == "prod" ? true : false

  tags = {
    Name        = "payment-gateway-public-alb"
    Environment = var.environment
    Component   = "payment-gateway"
  }
}

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

resource "aws_lambda_function" "fraud_detection" {
  filename         = "${path.module}/../../lambda/fraud-detection.zip"
  function_name    = "fraud-detection-${var.environment}"
  role             = var.lambda_execution_role_arn
  handler          = "com.payments.fraud.FraudDetector::handleRequest"
  source_code_hash = filebase64sha256("${path.module}/../../lambda/fraud-detection.zip")
  runtime          = "java17"
  timeout          = 30
  memory_size      = 1024

  environment {
    variables = {
      ENVIRONMENT     = var.environment
      FRAUD_DB_HOST   = var.fraud_db_endpoint
      RISK_THRESHOLD = "85"
    }
  }

  vpc_config {
    subnet_ids         = data.aws_subnets.private_app_subnets.ids
    security_group_ids = [var.app_security_group_id]
  }

  tags = {
    Name        = "fraud-detection"
    Environment = var.environment
    Component   = "fraud-detection"
  }
}

resource "aws_lambda_function_url" "fraud_detection_url" {
  function_name   = aws_lambda_function.fraud_detection.function_name
  authorization_type = "AWS_IAM"

  cors {
    allow_credentials = true
    allow_origins     = ["https://${var.domain_name}"]
    allow_methods     = ["POST"]
    allow_headers     = ["Content-Type", "Authorization"]
    max_age           = 300
  }
}

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

  alarm_actions = [var.autoscaling_topic_arn]
  ok_actions    = [var.autoscaling_topic_arn]

  tags = {
    Environment = var.environment
    Component   = "payment-gateway"
  }
}

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

  alarm_actions = [var.autoscaling_topic_arn]

  tags = {
    Environment = var.environment
    Component   = "payment-gateway"
  }
}

resource "aws_lb" "internal_nlb" {
  name               = "internal-nlb-${var.environment}"
  internal           = true
  load_balancer_type = "network"
  security_groups    = [var.internal_alb_security_group_id]
  subnets            = data.aws_subnets.private_app_subnets.ids

  enable_deletion_protection = var.environment == "prod" ? true : false

  tags = {
    Name        = "internal-nlb"
    Environment = var.environment
    Component   = "internal-backend"
  }
}

resource "aws_lb_target_group" "settlement_tg" {
  name     = "settlement-tg-${var.environment}"
  port     = 8081
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    port                = "8081"
    protocol            = "TCP"
    timeout             = 10
    unhealthy_threshold = 2
  }

  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "settlement_attachment" {
  target_group_arn = aws_lb_target_group.settlement_tg.arn
  target_id        = aws_instance.settlement_service.id
  port             = 8081
}

resource "aws_lb_listener" "settlement_listener" {
  load_balancer_arn = aws_lb.internal_nlb.arn
  port              = "8081"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.settlement_tg.arn
  }
}

resource "aws_appautoscaling_target" "payment_gateway_target" {
  max_capacity       = var.payment_gateway_max_size
  min_capacity       = var.payment_gateway_min_size
  resource_id        = "ASG:${aws_autoscaling_group.payment_gateway_asg.name}"
  scalable_dimension = "ec2:autoscaling:GroupDesiredCapacity"
  service_namespace  = "ec2"
}

resource "aws_appautoscaling_policy" "payment_gateway_target_policy" {
  name                   = "payment-gateway-autoscaling"
  policy_type            = "TargetTrackingScaling"
  resource_id            = aws_appautoscaling_target.payment_gateway_target.resource_id
  scalable_dimension     = aws_appautoscaling_target.payment_gateway_target.scalable_dimension
  service_namespace      = aws_appautoscaling_target.payment_gateway_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}
// === ARCHIVO: modules/compute/outputs.tf ===
output "public_alb_arn" {
  description = "ARN del balanceador de carga público para el gateway de pagos"
  value       = aws_lb.public_alb.arn
}

output "public_alb_dns_name" {
  description = "Nombre DNS del balanceador de carga público"
  value       = aws_lb.public_alb.dns_name
}

output "public_alb_zone_id" {
  description = "Zone ID del balanceador de carga público para Route 53"
  value       = aws_lb.public_alb.zone_id
}

output "public_alb_security_group_id" {
  description = "ID del security group asociado al ALB público"
  value       = var.web_security_group_id
}

output "internal_nlb_arn" {
  description = "ARN del balanceador de carga interno para servicios backend"
  value       = aws_lb.internal_nlb.arn
}

output "internal_nlb_dns_name" {
  description = "Nombre DNS del balanceador de carga interno"
  value       = aws_lb.internal_nlb.dns_name
}

output "internal_nlb_zone_id" {
  description = "Zone ID del balanceador de carga interno"
  value       = aws_lb.internal_nlb.zone_id
}

output "payment_gateway_target_group_arn" {
  description = "ARN del target group del gateway de pagos"
  value       = aws_lb_target_group.payment_gateway_tg.arn
}

output "settlement_target_group_arn" {
  description = "ARN del target group del servicio de liquidación"
  value       = aws_lb_target_group.settlement_tg.arn
}

output "settlement_service_instance_id" {
  description = "ID de la instancia del servicio de liquidación"
  value       = aws_instance.settlement_service.id
}

output "settlement_service_private_ip" {
  description = "IP privada de la instancia del servicio de liquidación"
  value       = aws_instance.settlement_service.private_ip
}

output "payment_gateway_asg_name" {
  description = "Nombre del Auto Scaling Group del gateway de pagos"
  value       = aws_autoscaling_group.payment_gateway_asg.name
}

output "payment_gateway_asg_desired_capacity" {
  description = "Capacidad deseada del Auto Scaling Group"
  value       = aws_autoscaling_group.payment_gateway_asg.desired_capacity
}

output "payment_gateway_asg_min_size" {
  description = "Tamaño mínimo del Auto Scaling Group"
  value       = aws_autoscaling_group.payment_gateway_asg.min_size
}

output "payment_gateway_asg_max_size" {
  description = "Tamaño máximo del Auto Scaling Group"
  value       = aws_autoscaling_group.payment_gateway_asg.max_size
}

output "payment_gateway_launch_template_id" {
  description = "ID del launch template para el gateway de pagos"
  value       = aws_launch_template.payment_gateway_lt.id
}

output "fraud_detection_function_name" {
  description = "Nombre de la función Lambda de detección de fraude"
  value       = aws_lambda_function.fraud_detection.function_name
}

output "fraud_detection_function_arn" {
  description = "ARN de la función Lambda de detección de fraude"
  value       = aws_lambda_function.fraud_detection.arn
}

output "fraud_detection_function_url" {
  description = "URL de la función Lambda de detección de fraude"
  value       = aws_lambda_function_url.fraud_detection_url.function_url
}

output "fraud_detection_qualified_arn" {
  description = "ARN calificado de la función Lambda (para aliases)"
  value       = aws_lambda_function.fraud_detection.qualified_arn
}

output "public_alb_listener_https_arn" {
  description = "ARN del listener HTTPS del ALB público"
  value       = aws_lb_listener.payment_gateway_https.arn
}

output "internal_nlb_listener_arn" {
  description = "ARN del listener del NLB interno"
  value       = aws_lb_listener.settlement_listener.arn
}

output "autoscaling_policy_scale_up_arn" {
  description = "ARN de la política de scale-up del Auto Scaling Group"
  value       = aws_autoscaling_policy.payment_gateway_scale_up.arn
}

output "autoscaling_policy_scale_down_arn" {
  description = "ARN de la política de scale-down del Auto Scaling Group"
  value       = aws_autoscaling_policy.payment_gateway_scale_down.arn
}

output "appautoscaling_target_id" {
  description = "ID del target de App Autoscaling para el ASG"
  value       = aws_appautoscaling_target.payment_gateway_target.id
}

output "cloudwatch_alarm_cpu_high_name" {
  description = "Nombre de la alarma de CPU alto para el gateway de pagos"
  value       = aws_cloudwatch_metric_alarm.payment_gateway_cpu_high.alarm_name
}

output "cloudwatch_alarm_request_count_name" {
  description = "Nombre de la alarma de requests por target"
  value       = aws_cloudwatch_metric_alarm.payment_gateway_request_count.alarm_name
}

output "all_load_balancers" {
  description = "Mapa con información de todos los balanceadores de carga"
  value = {
    public_alb = {
      arn       = aws_lb.public_alb.arn
      dns_name = aws_lb.public_alb.dns_name
      zone_id  = aws_lb.public_alb.zone_id
    }
    internal_nlb = {
      arn       = aws_lb.internal_nlb.arn
      dns_name = aws_lb.internal_nlb.dns_name
      zone_id  = aws_lb.internal_nlb.zone_id
    }
  }
}

output "all_target_groups" {
  description = "Mapa con todos los target groups"
  value = {
    payment_gateway = aws_lb_target_group.payment_gateway_tg.arn
    settlement      = aws_lb_target_group.settlement_tg.arn
  }
}

output "compute_summary" {
  description = "Resumen de la infraestructura de cómputo desplegada"
  value = {
    public_alb_endpoint            = aws_lb.public_alb.dns_name
    internal_nlb_endpoint          = aws_lb.internal_nlb.dns_name
    fraud_detection_endpoint       = aws_lambda_function_url.fraud_detection_url.function_url
    payment_gateway_asg_instances  = aws_autoscaling_group.payment_gateway_asg.desired_capacity
    settlement_instance_private_ip = aws_instance.settlement_service.private_ip
    environment                    = var.environment
  }
}


// === ARCHIVO: variables.tf ===
# Declaración de variables globales del proyecto de infraestructura
# Estas variables definen la configuración base que se aplica a todos los módulos
# Los valores se proporcionan a través de archivos terraform.tfvars por ambiente

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El ambiente debe ser uno de: dev, qa, prod"
  }
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block principal para la VPC"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Debe ser un CIDR válido (ej. 10.0.0.0/16)"
  }
}

variable "availability_zones" {
  description = "Lista de AZs a utilizar en el entorno"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs para subredes privadas (aplicación)"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "CIDRs para subredes de base de datos"
  type        = list(string)
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para salida a internet desde subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar una única NAT Gateway para todas las subredes privadas (optimización de costos)"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "Habilitar VPN Gateway para conectividad híbrida"
  type        = bool
  default     = false
}

variable "enable_dx_gateway" {
  description = "Habilitar Direct Connect Gateway para conectividad dedicada"
  type        = bool
  default     = false
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para VPC Flow Logs (cloud-watch-logs, s3, kinesis-data-firehose)"
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_retention_days" {
  description = "Días de retención para logs de flujo de VPC"
  type        = number
  default     = 90
}

variable "enable_transit_gateway" {
  description = "Habilitar Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso a recursos públicos"
  type        = list(string)
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Habilitar DNS hostnames en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "backend_bucket" {
  description = "Nombre del bucket S3 para almacenar el estado de Terraform"
  type        = string
}

variable "backend_dynamodb_table" {
  description = "Nombre de la tabla DynamoDB para lock del estado"
  type        = string
}

variable "nat_gateway_elastic_ips" {
  description = "Cantidad de Elastic IPs para NAT Gateways"
  type        = number
  default     = 0
}

variable "enable_guardduty" {
  description = "Habilitar GuardDuty para detección de amenazas"
  type        = bool
  default     = false
}

variable "enable_security_hub" {
  description = "Habilitar Security Hub para consolidación de hallazgos"
  type        = bool
  default     = false
}

variable "enable_config" {
  description = "Habilitar AWS Config para auditoría de recursos"
  type        = bool
  default     = false
}

variable "enable_cloudtrail" {
  description = "Habilitar CloudTrail para auditoría de eventos"
  type        = bool
  default     = true
}

variable "cloudtrail_bucket_name" {
  description = "Nombre del bucket S3 para logs de CloudTrail"
  type        = string
  default     = ""
}

variable "kms_administrator_arns" {
  description = "ARNs de usuarios que pueden administrar claves KMS"
  type        = list(string)
  default     = []
}

variable "kms_user_arns" {
  description = "ARNs de usuarios que pueden usar claves KMS"
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para los servidores de aplicación"
  type        = string
  default     = "t3.medium"
}

variable "instance_tenancy" {
  description = "Tenancy de las instancias: default o dedicated"
  type        = string
  default     = "default"
}

variable "ssh_key_name" {
  description = "Nombre del par de claves SSH para acceso a instancias"
  type        = string
  default     = ""
}

variable "asg_min_size" {
  description = "Número mínimo de instancias en el Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Número máximo de instancias en el Auto Scaling Group"
  type        = number
  default     = 10
}

variable "asg_desired_capacity" {
  description = "Número deseado de instancias en el Auto Scaling Group"
  type        = number
  default     = 3
}

variable "elb_access_logs_bucket" {
  description = "Bucket S3 para logs de acceso del ALB"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ARN del certificado ACM para HTTPS"
  type        = string
  default     = ""
}

variable "ebs_volume_size" {
  description = "Tamaño del volumen EBS en GB"
  type        = number
  default     = 100
}

variable "admin_cidr_blocks" {
  description = "Bloques CIDR para acceso administrativo"
  type        = list(string)
  default     = []
}

// === ARCHIVO: modules/network/variables.tf ===
# Variables específicas del módulo de red (VPC, subredes, tablas de rutas, NAT Gateway)
# Este módulo encapsula toda la configuración relacionada con la topología de red
# incluyendo segmentación entre subredes públicas, privadas y de base de datos

variable "vpc_name" {
  description = "Nombre identificador para la VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block principal de la VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para las subredes"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para subredes públicas (con acceso a internet)"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Bloques CIDR para subredes privadas (aplicaciones, sin acceso directo a internet)"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Bloques CIDR para subredes de base de datos (aislamiento máximo)"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Determina si se crean NAT Gateways para permitir salida a internet desde subredes privadas"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Si es true, se crea una única NAT Gateway en lugar de una por AZ (ahorra costos)"
  type        = bool
}

variable "enable_vpn_gateway" {
  description = "Habilita el Virtual Private Gateway para conexiones VPN site-to-site"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Habilita la resolución de DNS hostnames dentro de la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilita el soporte de DNS dentro de la VPC"
  type        = bool
  default     = true
}

variable "enable_transit_gateway" {
  description = "Configura attachment al Transit Gateway para conectividad entre VPCs"
  type        = bool
  default     = false
}

variable "transit_gateway_id" {
  description = "ID del Transit Gateway al cual conectar esta VPC"
  type        = string
  default     = ""
}

variable "map_public_ip_on_launch" {
  description = "Asignar IP pública automáticamente a instancias en subredes públicas"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Ambiente de despliegue para etiquetado"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "common_tags" {
  description = "Tags comunes heredados del proyecto"
  type        = map(string)
}

variable "nat_gateway_elastic_ips" {
  description = "Cantidad de Elastic IPs para NAT Gateways (debe coincidir con número de AZs si single_nat_gateway es false)"
  type        = number
  default     = 0
}

variable "enable_flow_log" {
  description = "Habilitar VPC Flow Logs para monitoreo de tráfico"
  type        = bool
  default     = true
}

variable "flow_log_destination_type" {
  description = "Tipo de destino para flow logs: cloud-watch-logs, s3, o kinesis-data-firehose"
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_cloudwatch_log_group_name" {
  description = "Nombre del Log Group en CloudWatch para flow logs"
  type        = string
  default     = ""
}

variable "flow_log_cloudwatch_log_group_arn" {
  description = "ARN del Log Group de CloudWatch existente para flow logs"
  type        = string
  default     = ""
}

variable "flow_log_iam_role_arn" {
  description = "ARN del rol IAM para publicación de flow logs"
  type        = string
  default     = ""
}

variable "flow_log_traffic_type" {
  description = "Tipo de tráfico a registrar: ACCEPT, REJECT, o ALL"
  type        = string
  default     = "ALL"
}

variable "flow_log_format" {
  description = "Formato personalizado para VPC Flow Logs"
  type        = string
  default     = "${version} ${account-id} ${interface-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${packets} ${bytes} ${start} ${end} ${action} ${log-status}"
}

variable "enable_classiclink" {
  description = "Habilitar ClassicLink para compatibilidad con EC2-Classic"
  type        = bool
  default     = false
}

variable "enable_ipv6" {
  description = "Habilitar IPv6 en la VPC"
  type        = bool
  default     = false
}

// === ARCHIVO: modules/network/main.tf ===
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

// === ARCHIVO: modules/network/outputs.tf ===
# Outputs del módulo de red: exposición de IDs y ARNs para consumo por otros módulos

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_arn" {
  description = "ARN de la VPC principal"
  value       = aws_vpc.main.arn
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "igw_id" {
  description = "ID del Internet Gateway (alias)"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways por zona de disponibilidad"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_elastic_ips" {
  description = "Elastic IPs asignadas a los NAT Gateways"
  value       = aws_eip.nat_gateway_eip[*].public_ip
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnet_app_ids" {
  description = "IDs de las subredes privadas de aplicación"
  value       = aws_subnet.private[*].id
}

output "private_subnet_data_ids" {
  description = "IDs de las subredes privadas de datos"
  value       = aws_subnet.database[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "IDs de las subredes de base de datos"
  value       = aws_subnet.database[*].id
}

output "database_subnet_group_id" {
  description = "ID del grupo de subredes de base de datos"
  value       = aws_subnet_group.database.id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas por AZ"
  value       = aws_route_table.private[*].id
}

output "public_subnet_cidrs" {
  description = "Bloques CIDR de las subredes públicas"
  value       = var.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "Bloques CIDR de las subredes privadas"
  value       = var.private_subnet_cidrs
}

output "database_subnet_cidrs" {
  description = "Bloques CIDR de las subredes de base de datos"
  value       = var.database_subnet_cidrs
}

output "availability_zones" {
  description = "Zonas de disponibilidad configuradas"
  value       = var.availability_zones
}

// === ARCHIVO: modules/security/variables.tf ===
# Variables específicas del módulo de seguridad
# Este módulo encapsula la configuración de IAM roles, políticas, security group
# y otros recursos de seguridad necesarios para el entorno de pagos

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se aplicarán los security groups"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
  default     = ""
}

variable "public_subnet_ids" {
  description = "IDs de subredes públicas"
  type        = list(string)
  default     = []
}

variable "private_subnet_ids" {
  description = "IDs de subredes privadas"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR autorizados para acceso a recursos"
  type        = list(string)
  default     = []
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos de seguridad"
  type        = map(string)
}

variable "enable_iam_roles" {
  description = "Habilitar la creación de roles IAM para los componentes"
  type        = bool
  default     = true
}

variable "enable_security_groups" {
  description = "Habilitar la creación de security groups"
  type        = bool
  default     = true
}

variable "create_payment_gateway_role" {
  description = "Crear rol IAM específico para el gateway de pagos"
  type        = bool
  default     = true
}

variable "create_settlement_role" {
  description = "Crear rol IAM específico para el sistema de liquidación"
  type        = bool
  default     = true
}

variable "create_fraud_engine_role" {
  description = "Crear rol IAM específico para el motor antifraude"
  type        = bool
  default     = true
}

variable "payment_gateway_policy" {
  description = "Política personalizada para el gateway de pagos (JSON)"
  type        = string
  default     = ""
}

variable "settlement_policy" {
  description = "Política personalizada para el sistema de liquidación (JSON)"
  type        = string
  default     = ""
}

variable "fraud_engine_policy" {
  description = "Política personalizada para el motor antifraude (JSON)"
  type        = string
  default     = ""
}

variable "security_group_rules" {
  description = "Definición de reglas de security groups personalizada"
  type = object({
    http_port      = number
    https_port     = number
    mysql_port     = number
    postgres_port  = number
    redis_port     = number
    rabbitmq_port  = number
    internal_port  = number
    monitoring_port = number
  })
  default = {
    http_port       = 80
    https_port      = 443
    mysql_port      = 3306
    postgres_port   = 5432
    redis_port      = 6379
    rabbitmq_port   = 5672
    internal_port   = 8080
    monitoring_port = 9090
  }
}

variable "allowed_ingress_ports" {
  description = "Puertos que permiten tráfico entrante desde fuentes externas"
  type        = list(number)
  default     = [443, 22]
}

variable "enable_cloudtrail" {
  description = "Habilitar CloudTrail para auditoría de eventos"
  type        = bool
  default     = true
}

variable "enable_guardduty" {
  description = "Habilitar GuardDuty para detección de amenazas"
  type        = bool
  default     = false
}

variable "enable_security_hub" {
  description = "Habilitar Security Hub para consolidación de hallazgos"
  type        = bool
  default     = false
}

variable "kms_key_administrators" {
  description = "ARNs de usuarios que pueden administrar la clave KMS"
  type        = list(string)
  default     = []
}

variable "kms_key_users" {
  description = "ARNs de usuarios que pueden usar la clave KMS para cifrado/descifrado"
  type        = list(string)
  default     = []
}

variable "enable_secrets_manager" {
  description = "Habilitar Secrets Manager para gestión de credenciales"
  type        = bool
  default     = true
}

variable "secrets_manager_secret_names" {
  description = "Nombres de los secrets a crear en Secrets Manager"
  type        = list(string)
  default     = []
}

variable "enable_waf" {
  description = "Habilitar WAF para protección de aplicaciones web"
  type        = bool
  default     = false
}

variable "waf_web_acl_rules" {
  description = "Configuración de reglas de WAF Web ACL"
  type        = any
  default     = {}
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación en recursos críticos"
  type        = bool
  default     = true
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "ID de cuenta de AWS"
  type        = string
  default     = ""
}

variable "logs_bucket_name" {
  description = "Nombre del bucket S3 para logs"
  type        = string
  default     = ""
}

variable "bastion_ssh_cidr" {
  description = "Bloque CIDR para acceso SSH al bastion"
  type        = string
  default     = "10.0.0.0/16"
}

// === ARCHIVO: modules/security/main.tf ===
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

// === ARCHIVO: modules/security/outputs.tf ===
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

// === ARCHIVO: modules/compute/variables.tf ===
# Variables específicas del módulo de cómputo
# Este módulo encapsula la configuración de instancias EC2, Auto Scaling Groups,
# Application Load Balancers y otros recursos de procesamiento

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los recursos de cómputo"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs de subredes públicas para el ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs de subredes privadas para las instancias de aplicación"
  type        = list(string)
}

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos de cómputo"
  type        = map(string)
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para los servidores de aplicación"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "ID de la AMI personalizada para las instancias"
  type        = string
  default     = ""
}

variable "ami_owner" {
  description = "Propietario de la AMI (aws, self, o account ID)"
  type        = string
  default     = "self"
}

variable "instance_key_name" {
  description = "Nombre del par de claves SSH para acceso a instancias"
  type        = string
  default     = ""
}

variable "min_size" {
  description = "Número mínimo de instancias en el Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Número máximo de instancias en el Auto Scaling Group"
  type        = number
  default     = 10
}

variable "desired_capacity" {
  description = "Número deseado de instancias en el Auto Scaling Group"
  type        = number
  default     = 3
}

variable "target_group_arns" {
  description = "ARNs de los target groups para el ALB"
  type        = list(string)
  default     = []
}

variable "alb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
  default     = ""
}

variable "alb_type" {
  description = "Tipo de ALB: application, network, o gateway"
  type        = string
  default     = "application"
}

variable "alb_internal" {
  description = "Determina si el ALB es interno (true) o público (false)"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación del ALB"
  type        = bool
  default     = true
}

variable "alb_idle_timeout" {
  description = "Tiempo de espera inactivo del ALB en segundos"
  type        = number
  default     = 60
}

variable "enable_cross_zone_load_balancing" {
  description = "Habilitar balanceo de carga entre AZs"
  type        = bool
  default     = true
}

variable "health_check_path" {
  description = "Path para health checks del ALB"
  type        = string
  default     = "/health"
}

variable "health_check_interval" {
  description = "Intervalo entre health checks en segundos"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout de health check en segundos"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Número de respuestas exitosas para considerar instancia saludable"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Número de respuestas fallidas para considerar instancia no saludable"
  type        = number
  default     = 2
}

variable "root_volume_size" {
  description = "Tamaño del volumen raíz en GB"
  type        = number
  default     = 50
}

variable "root_volume_type" {
  description = "Tipo de volumen raíz: gp2, gp3, io1, io2"
  type        = string
  default     = "gp3"
}

variable "root_volume_encrypted" {
  description = "Cifrar volumen raíz"
  type        = bool
  default     = true
}

variable "additional_ebs_volume_size" {
  description = "Tamaño de volumen EBS adicional en GB"
  type        = number
  default     = 0
}

variable "additional_ebs_volume_type" {
  description = "Tipo de volumen EBS adicional"
  type        = string
  default     = "gp3"
}

variable "user_data" {
  description = "Script de inicialización de instancias (base64)"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "Nombre del IAM instance profile para las instancias"
  type        = string
  default     = ""
}

variable "enable_monitoring" {
  description = "Habilitar monitoreo detallado de instancias"
  type        = bool
  default     = true
}

variable "enable_termination_protection" {
  description = "Habilitar protección contra terminación de instancias"
  type        = bool
  default     = false
}

variable "associate_public_ip_address" {
  description = "Asociar IP pública a instancias (solo en subredes públicas)"
  type        = bool
  default     = false
}

variable "placement_tenancy" {
  description = "Tenancy de las instancias: default o dedicated"
  type        = string
  default     = "default"
}

variable "enable_spot_instances" {
  description = "Habilitar uso de instancias spot para reducir costos"
  type        = bool
  default     = false
}

variable "spot_instance_max_price" {
  description = "Precio máximo para instancias spot (en USD por hora)"
  type        = string
  default     = ""
}

variable "asg_metrics" {
  description = "Métricas adicionales a collect para el ASG"
  type        = list(string)
  default     = []
}

variable "asg_suspended_processes" {
  description = "Procesos suspendidos del ASG"
  type        = list(string)
  default     = []
}

variable "default_cooldown" {
  description = "Cooldown predeterminado del ASG en segundos"
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "Tipo de health check: EC2 o ELB"
  type        = string
  default     = "ELB"
}

variable "web_security_group_id" {
  description = "ID del security group para la capa web"
  type        = string
}

variable "app_security_group_id" {
  description = "ID del security group para la capa de aplicación"
  type        = string
}

variable "db_security_group_id" {
  description = "ID del security group para la base de datos"
  type        = string
  default     = ""
}

variable "ec2_instance_profile_arn" {
  description = "ARN del perfil de instancia EC2"
  type        = string
  default     = ""
}

variable "ec2_instance_profile_name" {
  description = "Nombre del perfil de instancia EC2"
  type        = string
  default     = ""
}

variable "fraud_detection_endpoint" {
  description = "Endpoint del servicio de detección de fraude"
  type        = string
  default     = ""
}

variable "settlement_endpoint" {
  description = "Endpoint del servicio de liquidación"
  type        = string
  default     = ""
}

variable "db_endpoint" {
  description = "Endpoint de la base de datos"
  type        = string
  default     = ""
}

variable "fraud_db_endpoint" {
  description = "Endpoint de la base de datos de fraude"
  type        = string
  default     = ""
}

variable "lambda_execution_role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Nombre de dominio para la aplicación"
  type        = string
  default     = ""
}

variable "autoscaling_topic_arn" {
  description = "ARN del topic SNS para acciones de auto scaling"
  type        = string
  default     = ""
}

variable "internal_alb_security_group_id" {
  description = "ID del security group para el ALB interno"
  type        = string
  default     = ""
}

variable "payment_gateway_instance_type" {
  description = "Tipo de instancia para el gateway de pagos"
  type        = string
  default     = "t3.medium"
}

variable "settlement_instance_type" {
  description = "Tipo de instancia para el servicio de liquidación"
  type        = string
  default     = "t3.medium"
}

variable "payment_gateway_desired_capacity" {
  description = "Capacidad deseada del ASG del gateway de pagos"
  type        = number
  default     = 3
}

variable "payment_gateway_min_size" {
  description = "Tamaño mínimo del ASG del gateway de pagos"
  type        = number
  default     = 2
}

variable "payment_gateway_max_size" {
  description = "Tamaño máximo del ASG del gateway de pagos"
  type        = number
  default     = 10
}

variable "ssl_certificate_arn" {
  description = "ARN del certificado SSL"
  type        = string
  default     = ""
}

// === ARCHIVO: modules/compute/main.tf ===
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

// === ARCHIVO: modules/compute/outputs.tf ===
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
```
