# Configuración optimizada para Black Friday
# Este archivo contiene configuraciones específicas para manejar picos altos de tráfico

# ── CONFIGURACIÓN BÁSICA ──
project = "ecommerce-black-friday"
aws_region = "us-east-1"

# ── RED ──
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]

# ── COMPUTE ──
ami_id = "ami-0c02fb55956c7d316"  # Amazon Linux 2
instance_type = "t3.medium"        # Más potente para Black Friday
key_name = "ecommerce-key-bf"

# ── AUTO SCALING (OPTIMIZADO PARA BLACK FRIDAY) ──
asg_min_size = 3          # Mínimo 3 instancias
asg_max_size = 20         # Máximo 20 instancias para picos
asg_desired_capacity = 5  # 5 instancias por defecto

# ── BASE DE DATOS ──
motor = "mysql"
version_motor = "8.0"
instancia = "db.t3.large"  # Instancia más potente
usuario = "admin"
clave = "SecurePassword123!"
nombre_db = "ecommerce"
almacenamiento = 100
crear_replica = true      # Habilitar réplica para Black Friday

# ── CLOUDFRONT ──
enable_cloudfront = true
domain_name = "your-domain.com"
zone_id = "Z1234567890"
default_root_object = "index.html"

# ── MONITOREO ──
alert_email = "admin@your-domain.com"

# ── IAM ROLES (OPCIONAL) ──
enable_iam_roles = false
devops_trusted_account_id = ""
runtime_trusted_account_id = ""
frontend_trusted_account_id = ""
dba_trusted_account_id = ""
bi_trusted_account_id = ""

