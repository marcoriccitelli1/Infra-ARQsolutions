
// IDs de los Security Groups creados

output "sg_ids" {
  value = {
    alb = aws_security_group.alb_sg.id
    ec2 = aws_security_group.ec2_sg.id
    rds = aws_security_group.rds_sg.id
  }
}

output "kms_key_arn" {
  value = aws_kms_key.principal.arn
}


