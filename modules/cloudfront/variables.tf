variable "ecommerce" {
  type        = string
  description = "Nombre del proyecto/prefijo para recursos (p.ej. ecommerce-acme)"
}

variable "enabled" {
  type        = bool
  description = "Si es true, crea la distribución; si no, la omite"
  default     = true
}

variable "alb_dns_name" {
  type        = string
  description = "Nombre DNS del ALB (origen) al que va a apuntar CloudFront"
}

variable "waf_acl_arn" {
  type        = string
  description = "ARN del Web ACL de WAF que se asociará a la distro"
}

variable "certificate_arn" {
  type        = string
  description = "ARN del certificado ACM en us-east-1"
}

variable "default_root_object" {
  type        = string
  description = "Objeto raíz por defecto (p.ej. index.html)"
  default     = "index.html"
}
