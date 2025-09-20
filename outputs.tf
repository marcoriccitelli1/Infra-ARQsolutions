output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network.vpc_id
}

# ── OUTPUTS PARA BLACK FRIDAY ──
output "alb_dns_name" {
  description = "DNS name del Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "cloudfront_domain_name" {
  description = "Domain name de CloudFront"
  value       = var.enable_cloudfront ? module.cloudfront.distribution_domain_name : ""
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group"
  value       = module.autoscaling.autoscaling_group_name
}

output "monitoring_dashboard_url" {
  description = "URL del dashboard de monitoreo"
  value       = module.monitoring.dashboard_url
}

output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.rds.db_endpoint
}

