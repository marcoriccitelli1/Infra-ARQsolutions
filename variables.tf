variable "project" {
  type        = string
  description = "Nombre del proyecto de ecommerce, usado para tags y nombres de recursos"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR principal de la VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Lista de CIDRs para subredes públicas"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Lista de CIDRs para subredes privadas"
}

variable "availability_zones" {
  type        = list(string)
  description = "Lista de zonas de disponibilidad (AZs)"
}

# variables.tf (en la raíz)

variable "ami_id" {
  type        = string
  description = "AMI ID para la instancia EC2"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Nombre del par de claves para acceder por SSH"
}

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1" # o la que uses en el Lab
}

variable "motor" {
  description = "Motor de base de datos"
  type        = string
}

variable "version_motor" {
  description = "Versión del motor de base de datos"
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
  description = "Contraseña de la base"
  type        = string
  sensitive   = true
}

variable "nombre_db" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "almacenamiento" {
  description = "Espacio de almacenamiento en GB"
  type        = number
}

variable "crear_replica" {
  description = "Si se debe crear una réplica de lectura"
  type        = bool
  default     = false
}


variable "enable_cloudfront" {
  type        = bool
  description = "Crear o no la distribución CloudFront"
  default     = true
}

# — ACM —
variable "domain_name" {
  type        = string
  description = "Dominio para solicitar el certificado ACM (ej: example.com)"
}

variable "zone_id" {
  type        = string
  description = "Route53 Zone ID donde crear los registros de validación"
}

variable "acm_validation_method" {
  type        = string
  description = "Método de validación de ACM: DNS o EMAIL"
  default     = "DNS"
}

# — CloudFront —
variable "alb_dns_name" {
  type        = string
  description = "DNS name de tu Application Load Balancer (ej: alb-123456.us-west-2.elb.amazonaws.com)"
}

variable "waf_acl_arn" {
  type        = string
  description = "ARN del Web ACL de WAF que asociarás a la distro"
}

variable "default_root_object" {
  type        = string
  description = "Objeto raíz por defecto (ej: index.html)"
  default     = "index.html"
}



# --- IAM ROLES ---

variable "devops_trusted_account_id" {
  type        = string
  description = "Account ID que confía en el rol DevOps"
  default     = ""        # dejo vacío por defecto
}

variable "runtime_trusted_account_id" {
  type        = string
  description = "Account ID que confía en el rol AppRuntime"
  default     = ""
}

variable "frontend_trusted_account_id" {
  type        = string
  description = "Account ID que confía en el rol FrontendAdmin"
  default     = ""
}

variable "dba_trusted_account_id" {
  type        = string
  description = "Account ID que confía en el rol DBAAdmin"
  default     = ""
}

variable "bi_trusted_account_id" {
  type        = string
  description = "Account ID que confía en el rol BIAnalyst"
  default     = ""
}

variable "enable_iam_roles" {
  type        = bool
  description = "Si es true, Terraform crea los roles; si es false, salta estos módulos"
  default     = false    
}
