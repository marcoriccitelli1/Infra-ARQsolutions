// IDs de las OUs 
output "ou_ids" {
  value = {
    arq_solutions    = aws_organizations_organizational_unit.arq_solutions_core.id
    sw_core_dev      = aws_organizations_organizational_unit.sw_core_dev.id
    sw_core_prod     = aws_organizations_organizational_unit.sw_core_prod.id
    admin_ecommerce  = aws_organizations_organizational_unit.admin_ecommerce.id
    dba_ecommerce    = aws_organizations_organizational_unit.dba_ecommerce_prod.id
    dba_ecommerce_reportes = aws_organizations_organizational_unit.dba_ecommerce_reportes.id
  }
}

output "account_ids" {
  value = {
    arq_solutions    = aws_organizations_account.arq_solutions_account.id
    sw_core_dev      = aws_organizations_account.sw_core_dev_account.id
    sw_core_prod     = aws_organizations_account.sw_core_prod_account.id
    admin_ecommerce  = aws_organizations_account.admin_ecommerce_account.id
    dba_ecommerce    = aws_organizations_account.dba_ecommerce_prod_account.id
    dba_ecommerce_reportes = aws_organizations_account.dba_ecommerce_reportes_account.id
  }
}
