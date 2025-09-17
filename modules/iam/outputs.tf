output "role_name" {
  description = "Nombre del rol IAM creado"
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "ARN del rol IAM creado"
  value       = aws_iam_role.this.arn
}
