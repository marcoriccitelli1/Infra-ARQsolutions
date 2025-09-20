variable "ecommerce" {
  description = "Nombre del proyecto ecommerce"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "alb_arn_suffix" {
  description = "Suffix del ARN del ALB"
  type        = string
}

variable "asg_name" {
  description = "Nombre del Auto Scaling Group"
  type        = string
}

variable "rds_identifier" {
  description = "Identificador de la instancia RDS"
  type        = string
}

variable "cloudfront_distribution_id" {
  description = "ID de la distribución CloudFront"
  type        = string
}

variable "alert_email" {
  description = "Email para alertas (opcional)"
  type        = string
  default     = ""
}

