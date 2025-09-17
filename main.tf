# ── CERTIFICADO ACM (usa us-east-1) ──
module "certificado_acm" {
  count = var.enable_cloudfront ? 1 : 0
  source = "./modules/certificado_acm"

  providers = {
    aws = aws.us_east_1
  }

  domain_name       = var.domain_name
  ecommerce         = var.project
  zone_id           = var.zone_id
  validation_method = var.acm_validation_method
}

# ── DISTRIBUCIÓN CLOUDFRONT (usa us-east-1) ──
module "cloudfront" {
  source = "./modules/cloudfront"

  providers = {
    aws = aws.us_east_1
  }

  ecommerce           = var.project
  enabled             = var.enable_cloudfront
  alb_dns_name        = var.alb_dns_name
  waf_acl_arn         = var.waf_acl_arn
  certificate_arn     = var.enable_cloudfront ? module.certificado_acm[0].certificate_arn : ""
  default_root_object = var.default_root_object
}

# ── RED Y SUBREDES ──
module "network" {
  source            = "./modules/network"
  ecommerce         = var.project
  vpc_cidr          = var.vpc_cidr
  subredes_publicas = var.public_subnet_cidrs
  subredes_privadas = var.private_subnet_cidrs
  zonas_az          = var.availability_zones
}

# ── CÓMPUTO (EC2 / Bastion) ──
module "compute" {
  source             = "./modules/compute"
  ecommerce          = var.project
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  private_subnet_id  = module.network.subredes_privadas_ids[0]
  public_subnet_id   = module.network.subredes_publicas_ids[0]
  security_group_ids = [module.security.sg_ids.ec2]
  enable_bastion     = true
}

# ── SEGURIDAD (SG, KMS, etc.) ──
module "security" {
  source    = "./modules/security"
  ecommerce = var.project
  vpc_id    = module.network.vpc_id
}

# ── OBSERVABILIDAD (CloudTrail, Config, CW) ──
module "observability" {
  source               = "./modules/observability"
  trail_name           = "ecommerce-trail"
  s3_bucket            = "ecommerce-logs-bucket-679835925523"
  config_role_name     = "ecommerce-config-role"
  config_recorder_name = "ecommerce-config-recorder"
  config_channel_name  = "ecommerce-config-channel"
}

# ── RDS (DB Instance) ──
module "rds" {
  source                = "./modules/rds"
  ecommerce             = var.project
  motor                 = var.motor
  version_motor         = var.version_motor
  instancia             = var.instancia
  usuario               = var.usuario
  clave                 = var.clave
  nombre_db             = var.nombre_db
  almacenamiento        = var.almacenamiento
  subredes_privadas_ids = module.network.subredes_privadas_ids
  sg_rds_id             = module.security.sg_ids.rds
  kms_key_arn           = module.security.kms_key_arn
  crear_replica         = var.crear_replica
}

# ── IAM – Roles técnicos (solo si enable_iam_roles = true) ──
module "iam_devops" {
  count     = var.enable_iam_roles ? 1 : 0
  source    = "./modules/iam"
  providers = { aws = aws.central }

  role_name          = "DevOpsRole"
  trusted_account_id = var.devops_trusted_account_id
  policy_arn         = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "iam_runtime" {
  count     = var.enable_iam_roles ? 1 : 0
  source    = "./modules/iam"
  providers = { aws = aws.central }

  role_name          = "AppRuntimeRole"
  trusted_account_id = var.runtime_trusted_account_id
  policy_arn         = "arn:aws:iam::aws:policy/PowerUserAccess"
}

module "iam_frontend_admin" {
  count     = var.enable_iam_roles ? 1 : 0
  source    = "./modules/iam"
  providers = { aws = aws.central }

  role_name          = "FrontendAdminRole"
  trusted_account_id = var.frontend_trusted_account_id
  policy_arn         = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

module "iam_dba_prod" {
  count     = var.enable_iam_roles ? 1 : 0
  source    = "./modules/iam"
  providers = { aws = aws.central }

  role_name          = "DBAAdminRole"
  trusted_account_id = var.dba_trusted_account_id
  policy_arn         = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

module "iam_bi_analyst" {
  count     = var.enable_iam_roles ? 1 : 0
  source    = "./modules/iam"
  providers = { aws = aws.central }

  role_name          = "BIAnalystRole"
  trusted_account_id = var.bi_trusted_account_id
  policy_arn         = "arn:aws:iam::aws:policy/AthenaFullAccess"
}
