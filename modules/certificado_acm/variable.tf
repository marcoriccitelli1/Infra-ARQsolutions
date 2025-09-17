variable "domain_name" {
  type        = string
  description = "Dominio para el certificado ACM (ej: example.com)"
}

variable "ecommerce" {
  type        = string
  description = "Nombre del proyecto/ecommerce, para etiquetas"
}

variable "zone_id" {
  type        = string
  description = "ID de la Hosted Zone en Route53 donde añadir el registro DNS"
}

variable "validation_method" {
  type        = string
  description = "Método de validación de ACM: DNS o EMAIL"
  default     = "DNS"
}
