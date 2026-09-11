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