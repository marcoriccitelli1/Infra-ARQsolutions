terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Solicita el certificado TLS en us-east-1
resource "aws_acm_certificate" "cloudfront_cert" {
  domain_name       = var.domain_name
  validation_method = var.validation_method

  tags = {
    Proyecto = var.ecommerce
  }
}

# Crea registros en Route53 para la validación por DNS
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront_cert.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      record  = dvo.resource_record_value
      zone_id = var.zone_id
    }
  }

  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
  zone_id = each.value.zone_id
}

# Espera a que ACM valide el certificado
resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.cloudfront_cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}
