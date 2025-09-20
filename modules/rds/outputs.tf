output "db_endpoint" {
  description = "Endpoint de la base de datos principal"
  value       = aws_db_instance.principal.endpoint
}

output "replica_endpoint" {
  description = "Endpoint de la réplica de lectura"
  value       = try(aws_db_instance.replica[0].endpoint, null)
}

output "db_identifier" {
  description = "Identificador de la instancia RDS"
  value       = aws_db_instance.principal.identifier
}