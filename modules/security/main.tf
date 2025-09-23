// Clave KMS para RDS, logs, backups.
resource "aws_kms_key" "principal" {
  description             = "Clave principal para encriptacion"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Name = "${var.ecommerce}-kms"
  }
}

// Web ACL de WAF para CloudFront, con proteccion basica por IP
resource "aws_wafv2_web_acl" "principal" {
  name        = "${var.ecommerce}-waf"
  scope       = var.waf_scope
  description = "WAF para prevenir DDOS"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.ecommerce}-waf"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "Limitaciones-basicas"
    priority = 1

    action {
      count {} // Contamos los intentos para ajustar el limite de bloqueo
    }

    statement {
      rate_based_statement {
        limit              = 5000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "bloqueo-ip"
    }
  }

  tags = {
    Proyecto = var.ecommerce
  }
}

// Security Group para el ALB 
// Acepta trafico HTTP (80) y HTTPS (443) desde Internet.
// HTTP es solo para redireccion a HTTPS.
resource "aws_security_group" "alb_sg" {
  name        = "${var.ecommerce}-sg-alb"
  description = "Permite trafico publico al ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ecommerce}-sg-alb"
  }
}

// Security Group para EC2 (servidores de aplicacion)
// Solo permite trafico HTTPS (puerto 443) proveniente del ALB.
// HTTPS end to end.
resource "aws_security_group" "ec2_sg" {
  name        = "${var.ecommerce}-sg-ec2"
  description = "Solo permite trafico HTTPS desde el ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id] // Solo desde el ALB
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ecommerce}-sg-ec2"
  }
}

// Security Group para RDS
// Solo permite trafico desde las instancias EC2
resource "aws_security_group" "rds_sg" {
  name        = "${var.ecommerce}-sg-rds"
  description = "Solo permite trafico desde EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ecommerce}-sg-rds"
  }
}
