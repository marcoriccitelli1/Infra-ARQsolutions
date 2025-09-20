output "cloudfront_domain_name" {
  description = "Dominio de la distro CloudFront"
  value = try(
    aws_cloudfront_distribution.principal[0].domain_name,
    ""
  )
}

output "distribution_domain_name" {
  description = "Domain name de la distribución CloudFront"
  value       = var.enabled ? aws_cloudfront_distribution.principal[0].domain_name : ""
}

output "distribution_id" {
  description = "ID de la distribución CloudFront"
  value       = var.enabled ? aws_cloudfront_distribution.principal[0].id : ""
}