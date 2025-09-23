// Nombre del proyecto (usado para nombrar los recursos)
variable "ecommerce" {
  description = "Nombre del proyecto de ecommerce"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR para la VPC de ecommerce"
  type        = string
  default     = "10.0.0.0/16"
}

// Subredes publicas, declararlo en el main.tf raiz
variable "subredes_publicas" {
  description = "Lista de CIDRs publicas"
  type        = list(string)

  validation {
    condition     = length(var.subredes_publicas) == 2
    error_message = "2 subredes publicas (una por AZ)."
  }
}

// Subredes privadas, declararlo en el main.tf raiz
variable "subredes_privadas" {
  description = "Lista de CIDRs privadas"
  type        = list(string)

  validation {
    condition     = length(var.subredes_privadas) == 2
    error_message = "2 subredes privadas (una por AZ)."
  }
}

// Lista de AZ, declararlo en el main.tf raiz
variable "zonas_az" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)

  validation {
    condition     = length(var.zonas_az) == 2
    error_message = "2 AZ."
  }
}
