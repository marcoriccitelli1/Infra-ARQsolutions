resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
}

# Unidades Organizativas
resource "aws_organizations_organizational_unit" "arq_solutions_core" {
  name      = "OU-ARQ-Solutions-Core"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "sw_core_dev" {
  name      = "OU-SW-Core-Dev"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "sw_core_prod" {
  name      = "OU-SW-Core-Prod"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "admin_ecommerce" {
  name      = "OU-Admin-Ecommerce"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "dba_ecommerce_prod" {
  name      = "OU-DBA-Ecommerce-Prod"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "dba_ecommerce_reportes" {
  name      = "OU-DBA-Ecommerce-Reportes"
  parent_id = aws_organizations_organization.this.roots[0].id
}

# Cuentas bajo cada OU
resource "aws_organizations_account" "arq_solutions_account" {
  name      = "cuenta-arq-solutions"
  email     = var.arq_solutions_email
  parent_id = aws_organizations_organizational_unit.arq_solutions_core.id
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "sw_core_dev_account" {
  name      = "cuenta-sw-core-dev"
  email     = var.sw_core_dev_email
  parent_id = aws_organizations_organizational_unit.sw_core_dev.id
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "sw_core_prod_account" {
  name      = "cuenta-sw-core-prod"
  email     = var.sw_core_prod_email
  parent_id = aws_organizations_organizational_unit.sw_core_prod.id
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "admin_ecommerce_account" {
  name      = "cuenta-admin-ecommerce"
  email     = var.admin_ecommerce_email
  parent_id = aws_organizations_organizational_unit.admin_ecommerce.id
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "dba_ecommerce_prod_account" {
  name      = "cuenta-dba-ecommerce-prod"
  email     = var.dba_ecommerce_prod_email
  parent_id = aws_organizations_organizational_unit.dba_ecommerce_prod.id
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "dba_ecommerce_reportes_account" {
  name      = "cuenta-dba-ecommerce-reportes"
  email     = var.dba_ecommerce_reportes_email
  parent_id = aws_organizations_organizational_unit.dba_ecommerce_reportes.id
  role_name = "OrganizationAccountAccessRole"
}
