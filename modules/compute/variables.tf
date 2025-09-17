variable "ecommerce" {
  type        = string
  description = "Nombre del proyecto de ecommerce"
}

variable "ami_id" {
  type        = string
  description = "AMI de la instancia EC2"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancia EC2"
}

variable "private_subnet_id" {
  type        = string
  description = "Subnet privada donde irá la EC2"
}

variable "public_subnet_id" {
  type        = string
  description = "Subnet pública para bastion (opcional)"
  default     = null
}

variable "key_name" {
  type        = string
  description = "Nombre del par de claves SSH"
  default     = null
}

variable "security_group_ids" {
  type        = list(string)
  description = "Lista de Security Groups"
}

variable "enable_bastion" {
  type        = bool
  description = "Si se habilita o no el bastion host"
  default     = false
}
