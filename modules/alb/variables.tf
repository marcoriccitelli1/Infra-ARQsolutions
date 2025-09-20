variable "ecommerce" {
  description = "Nombre del proyecto ecommerce"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN del certificado SSL"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID del security group para ALB"
  type        = string
  default     = null
}

