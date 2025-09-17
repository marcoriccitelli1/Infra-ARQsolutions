// Nombre del proyecto para nombrar recursos
variable "ecommerce" {
  type        = string
  description = "Nombre del proyecto de ecommerce"
}

// ID de la VPC
variable "vpc_id" {
  type        = string
  description = "ID de la VPC"
}

// Alcance del WAF: usamos CLOUDFRONT porque nuestro punto de entrada es por ahi. 
variable "waf_scope" {
  type        = string
  description = "CLOUDFRONT es el punto de entrada"
  default     = "CLOUDFRONT"
}


