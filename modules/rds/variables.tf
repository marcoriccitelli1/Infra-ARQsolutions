variable "ecommerce" {
  description = "Nombre del proyecto de ecommerce"
  type        = string
}

variable "motor" {
  description = "Motor de base de datos"
  type        = string
}

variable "version_motor" {
  description = "Version del motor de base de datos"
  type        = string
}

variable "instancia" {
  description = "Tipo de instancia RDS"
  type        = string
}

variable "usuario" {
  description = "Usuario administrador"
  type        = string
}

variable "clave" {
  description = "Contrasena de la base"
  type        = string
  sensitive   = true
}

variable "nombre_db" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "almacenamiento" {
  description = "Espacio en GB"
  type        = number
}

variable "subredes_privadas_ids" {
  description = "Lista de IDs de subredes privadas"
  type        = list(string)
}

variable "sg_rds_id" {
  description = "ID del security group de RDS"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN de la clave KMS"
  type        = string
}

variable "crear_replica" {
  description = "Si se debe crear una réplica de lectura"
  type        = bool
  default     = false
}
