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