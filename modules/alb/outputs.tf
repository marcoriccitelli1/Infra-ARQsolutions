output "alb_dns_name" {
  description = "DNS name del Application Load Balancer"
  value       = aws_lb.principal.dns_name
}

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.principal.arn
}


output "alb_arn_suffix" {
  description = "Sufijo de ARN para dimensión CloudWatch LoadBalancer (app/<name>/<hash>)"
  value       = element(split("loadbalancer/", aws_lb.principal.arn), 1)
}

output "target_group_arn" {
  description = "ARN del Target Group"
  value       = aws_lb_target_group.app.arn
}

output "target_group_arn_suffix" {
  description = "Sufijo de ARN para dimensión CloudWatch TargetGroup (targetgroup/<name>/<hash>)"
  value       = aws_lb_target_group.app.arn_suffix
}

output "alb_security_group_id" {
  description = "ID del security group del ALB"
  value       = aws_security_group.alb.id
}
