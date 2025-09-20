terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

// CloudFront que usa el ALB como origen
resource "aws_cloudfront_distribution" "principal" {
  count                = var.enabled ? 1 : 0
  enabled              = true
  is_ipv6_enabled      = true
  comment              = "Distribucion principal para ${var.ecommerce}"
  default_root_object  = var.default_root_object

  origin {
    domain_name = var.alb_dns_name
    origin_id   = "alb-${var.ecommerce}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "alb-${var.ecommerce}"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = true
      headers      = ["*"]
      cookies {
        forward = "all"
      }
    }

    # Optimizaciones para Black Friday - cache más agresivo
    min_ttl     = 0
    default_ttl = 86400    # 24 horas para contenido estático
    max_ttl     = 31536000 # 1 año para assets estáticos

    compress = true
  }

  # Cache behavior para assets estáticos (CSS, JS, imágenes)
  ordered_cache_behavior {
    path_pattern     = "/assets/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "alb-${var.ecommerce}"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      headers      = ["Origin"]
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 31536000 # 1 año
    max_ttl     = 31536000 # 1 año
    compress    = true
  }

  # Cache behavior para API calls (menos agresivo)
  ordered_cache_behavior {
    path_pattern     = "/api/*"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "alb-${var.ecommerce}"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = true
      headers      = ["*"]
      cookies {
        forward = "all"
      }
    }

    min_ttl     = 0
    default_ttl = 0      # No cache para API por defecto
    max_ttl     = 3600   # Máximo 1 hora si se cachea
    compress    = true
  }

  web_acl_id = var.waf_acl_arn

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["AR"]
    }
  }

  tags = {
    Proyecto = var.ecommerce
  }
}
