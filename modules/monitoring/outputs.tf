output "dashboard_url" {
  description = "URL del dashboard de CloudWatch"
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${aws_cloudwatch_dashboard.black_friday.dashboard_name}"
}

output "sns_topic_arn" {
  description = "ARN del SNS topic para alertas"
  value       = aws_sns_topic.alerts.arn
}

output "log_group_name" {
  description = "Nombre del log group"
  value       = aws_cloudwatch_log_group.app_logs.name
}

