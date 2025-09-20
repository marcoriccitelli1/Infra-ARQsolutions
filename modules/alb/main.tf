# Application Load Balancer para alta disponibilidad
resource "aws_lb" "principal" {
  name               = "${var.ecommerce}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_group_id != null ? [var.alb_security_group_id] : [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name     = "${var.ecommerce}-alb"
    Proyecto = var.ecommerce
  }
}

# Target Group para las instancias de la aplicación
resource "aws_lb_target_group" "app" {
  name     = "${var.ecommerce}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  tags = {
    Name     = "${var.ecommerce}-target-group"
    Proyecto = var.ecommerce
  }
}

# Listener HTTP (redirige a HTTPS)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.principal.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Listener HTTPS (solo si hay certificado)
resource "aws_lb_listener" "https" {
  count             = var.certificate_arn != "" ? 1 : 0
  load_balancer_arn = aws_lb.principal.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# Security Group para ALB
resource "aws_security_group" "alb" {
  name_prefix = "${var.ecommerce}-alb-"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
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
    Name     = "${var.ecommerce}-alb-sg"
    Proyecto = var.ecommerce
  }
}

