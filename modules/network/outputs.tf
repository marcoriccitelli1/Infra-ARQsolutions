// ID de la VPC
output "vpc_id" {
  value = aws_vpc.principal.id
}

// IDs de las subredes publicas
output "subredes_publicas_ids" {
  value = aws_subnet.publica[*].id
}

// IDs de las subredes privadas
output "subredes_privadas_ids" {
  value = aws_subnet.privada[*].id
}
