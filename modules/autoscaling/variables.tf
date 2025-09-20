variable "ecommerce" {
  description = "Nombre del proyecto ecommerce"
  type        = string
}

variable "ami_id" {
  description = "AMI ID para las instancias"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
}

variable "key_name" {
  description = "Nombre de la clave SSH"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID del security group"
  type        = string
}

variable "target_group_arn" {
  description = "ARN del target group del ALB"
  type        = string
}

variable "alb_arn_suffix" {
  description = "Suffix del ARN del ALB para métricas"
  type        = string
}

variable "min_size" {
  description = "Número mínimo de instancias"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Número máximo de instancias"
  type        = number
  default     = 10
}

variable "desired_capacity" {
  description = "Número deseado de instancias"
  type        = number
  default     = 2
}

