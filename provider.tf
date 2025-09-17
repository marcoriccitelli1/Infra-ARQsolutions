terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider por defecto (todos los módulos “normales” usarán este)
provider "aws" {
  region = var.aws_region
}

# Alias para la cuenta "central" de ARQ-solutions
provider "aws" {
  alias  = "central"
  region = var.aws_region
}

# Alias para sw-core-dev (asume rol DevOpsRole)
provider "aws" {
  alias  = "sw_core_dev"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::111111111111:role/DevOpsRole"
  }
}

# Alias para sw-core-prod (asume rol AppRuntimeRole)
provider "aws" {
  alias  = "sw_core_prod"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::222222222222:role/AppRuntimeRole"
  }
}

# Alias para admin-ecommerce (asume rol FrontendAdminRole)
provider "aws" {
  alias  = "admin_ecommerce"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::333333333333:role/FrontendAdminRole"
  }
}

# Alias para dba-ecommerce-prod (asume rol DBAAdminRole)
provider "aws" {
  alias  = "dba_ecommerce_prod"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::444444444444:role/DBAAdminRole"
  }
}

# Alias para dba-ecommerce-reportes (asume rol BIAnalystRole)
provider "aws" {
  alias  = "dba_ecommerce_reportes"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::555555555555:role/BIAnalystRole"
  }
}

# Alias para ACM y CloudFront en us-east-1
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
