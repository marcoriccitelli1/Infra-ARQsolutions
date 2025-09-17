output "certificate_arn" {
  description = "ARN del certificado ACM validado"
  value       = aws_acm_certificate.cloudfront_cert.arn
}
