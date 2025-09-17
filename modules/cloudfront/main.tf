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
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
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

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400

    compress = true
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
