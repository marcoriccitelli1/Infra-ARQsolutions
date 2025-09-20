# Configuración optimizada para eventos de alto tráfico
# Arquitectura escalable para e-commerce durante picos de demanda

# ── CONFIGURACIÓN BÁSICA ──
project = "tienda-online-scalable"
aws_region = "us-east-1"

# ── RED ──
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]

# ── COMPUTE ──
ami_id = "ami-0c02fb55956c7d316"  # Amazon Linux 2
instance_type = "t3.medium"        # Más potente para Black Friday
key_name = "your-key-name"

# ── AUTO SCALING (OPTIMIZADO PARA EVENTOS DE ALTO TRÁFICO) ──
asg_min_size = 2          # Capacidad mínima reducida para controlar costos
asg_max_size = 6          # Límite superior ajustado para presupuesto de $10k/año
asg_desired_capacity = 3  # Capacidad base optimizada para costo-efectividad

# ── BASE DE DATOS ──
motor = "mysql"
version_motor = "8.0"
instancia = "db.t3.medium"  # Instancia balanceada costo/rendimiento
usuario = "admin"
clave = "SecurePassword123!"
nombre_db = "ecommerce"
almacenamiento = 50       # Almacenamiento optimizado para presupuesto
crear_replica = false     # Deshabilitar réplica para controlar costos

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

