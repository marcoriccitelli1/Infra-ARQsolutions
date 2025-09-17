output "cloudfront_domain_name" {
  description = "Dominio de la distro CloudFront"
  value = try(
    aws_cloudfront_distribution.principal[0].domain_name,
    ""
  )
}