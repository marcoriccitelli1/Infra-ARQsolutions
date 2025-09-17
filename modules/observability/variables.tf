variable "trail_name" {
  description = "Nombre del CloudTrail"
  type        = string
}

variable "multi_region" {
  description = "Habilitar CloudTrail multirregional"
  type        = bool
  default     = true
}

variable "log_file_validation" {
  description = "Habilitar validación de archivos de log"
  type        = bool
  default     = true
}

variable "global_events" {
  description = "Incluir eventos globales en el trail"
  type        = bool
  default     = true
}

variable "s3_bucket" {
  description = "Bucket S3 para almacenar logs"
  type        = string
}

variable "config_role_name" {
  description = "Nombre del rol IAM para AWS Config"
  type        = string
}

variable "config_policy_arn" {
  description = "ARN de la política a adjuntar al rol AWS Config"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

variable "config_recorder_name" {
  description = "Nombre del Configuration Recorder"
  type        = string
}

variable "config_all_supported" {
  description = "Grabar todos los recursos soportados por AWS Config"
  type        = bool
  default     = true
}

variable "config_channel_name" {
  description = "Nombre del Delivery Channel"
  type        = string
}
