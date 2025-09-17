# Región principal
aws_region        = "us-east-1"

# Flags de despliegue
enable_cloudfront = false
enable_iam_roles  = false

# Proyecto / nombre de ecommerce
project           = "ecommerce-acme"

# Variables de red
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# Configuración de cómputo
ami_id        = "ami-053b0d53c279acc90"
instance_type = "t3.micro"
key_name      = null

# Configuración de RDS
motor          = "mysql"
version_motor  = "8.0"
instancia      = "db.t3.micro"
usuario        = "admin"
clave          = "SuperSecret123"
nombre_db      = "ecommerce"
almacenamiento = 20
crear_replica  = false

# ACM / CloudFront
domain_name           = "acme-ecommerce.example.com"
zone_id               = "Z1234567890ABCDEF"
alb_dns_name          = "alb-ecommerce-acme-123456.us-east-1.elb.amazonaws.com"
waf_acl_arn           = ""
acm_validation_method = "DNS"
