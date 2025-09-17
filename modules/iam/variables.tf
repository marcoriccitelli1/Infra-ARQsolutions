variable "role_name" {
  description = "Nombre del rol IAM que se va a crear"
  type        = string
}

variable "trusted_account_id" {
  description = "ID de la cuenta que podra asumir el rol"
  type        = string
}

variable "policy_arn" {
  description = "ARN de la politica gestionada de AWS a aplicar al rol"
  type        = string
}
