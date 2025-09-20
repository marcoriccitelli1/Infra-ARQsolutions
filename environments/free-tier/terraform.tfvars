# Configuración OPTIMIZADA para capa gratuita de AWS
# Mínimo costo - Solo lo esencial para la facultad

# ── CONFIGURACIÓN BÁSICA ──
project = "ecommerce-facultad"
aws_region = "us-east-1"

# ── RED ──
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]

# ── COMPUTE (CAPA GRATUITA) ──
ami_id = "ami-0c02fb55956c7d316"  # Amazon Linux 2
instance_type = "t3.micro"         # GRATIS en capa gratuita
key_name = "ecommerce-key"

# ── AUTO SCALING (MÍNIMO) ──
asg_min_size = 1          # Solo 1 instancia
asg_max_size = 2          # Máximo 2 instancias
asg_desired_capacity = 1   # Solo 1 instancia por defecto

# ── BASE DE DATOS (DESHABILITADA) ──
motor = "mysql"
version_motor = "8.0"
instancia = "db.t3.micro"  # GRATIS en capa gratuita
usuario = "admin"
clave = "SecurePassword123!"
nombre_db = "ecommerce"
almacenamiento = 20        # Mínimo
crear_replica = false     # Sin réplica

# ── CLOUDFRONT (DESHABILITADO) ──
enable_cloudfront = false
domain_name = ""
zone_id = ""
default_root_object = "index.html"
alb_dns_name = ""
waf_acl_arn = ""

# ── MONITOREO (MÍNIMO) ──
alert_email = ""

# ── IAM ROLES (DESHABILITADOS) ──
enable_iam_roles = false
devops_trusted_account_id = ""
runtime_trusted_account_id = ""
frontend_trusted_account_id = ""
dba_trusted_account_id = ""
bi_trusted_account_id = ""
