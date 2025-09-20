# Dashboard de CloudWatch para monitoreo de Black Friday
resource "aws_cloudwatch_dashboard" "black_friday" {
  dashboard_name = "${var.ecommerce}-black-friday-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_arn_suffix],
            [".", "TargetResponseTime", ".", "."],
            [".", "HTTPCode_Target_2XX_Count", ".", "."],
            [".", "HTTPCode_Target_4XX_Count", ".", "."],
            [".", "HTTPCode_Target_5XX_Count", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "ALB Metrics - Black Friday"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.asg_name],
            [".", "NetworkIn", ".", "."],
            [".", "NetworkOut", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "EC2 Metrics - Auto Scaling"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", var.rds_identifier],
            [".", "DatabaseConnections", ".", "."],
            [".", "FreeableMemory", ".", "."],
            [".", "FreeStorageSpace", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "RDS Metrics - Database Performance"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = var.cloudfront_distribution_id != "" ? [
            ["AWS/CloudFront", "Requests", "DistributionId", var.cloudfront_distribution_id],
            [".", "BytesDownloaded", ".", "."],
            [".", "CacheHitRate", ".", "."]
          ] : [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_arn_suffix],
            [".", "TargetResponseTime", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = var.cloudfront_distribution_id != "" ? "CloudFront Metrics - CDN Performance" : "ALB Performance - Load Balancer"
          period  = 300
        }
      }
    ]
  })
}

# Alarmas críticas para Black Friday
resource "aws_cloudwatch_metric_alarm" "high_error_rate" {
  alarm_name          = "${var.ecommerce}-high-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "50"
  alarm_description   = "High 5XX error rate detected"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "high_response_time" {
  alarm_name          = "${var.ecommerce}-high-response-time"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "2"
  alarm_description   = "High response time detected"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_high_cpu" {
  alarm_name          = "${var.ecommerce}-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "RDS high CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_identifier
  }
}

# SNS Topic para alertas
resource "aws_sns_topic" "alerts" {
  name = "${var.ecommerce}-black-friday-alerts"

  tags = {
    Proyecto = var.ecommerce
  }
}

# SNS Topic Subscription (email)
resource "aws_sns_topic_subscription" "email" {
  count     = var.alert_email != "" ? 1 : 0
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# Log Group para logs de aplicación
resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/ec2/${var.ecommerce}"
  retention_in_days = 30

  tags = {
    Proyecto = var.ecommerce
  }
}

# Métricas personalizadas para monitoreo de negocio
resource "aws_cloudwatch_log_metric_filter" "order_created" {
  name           = "${var.ecommerce}-order-created"
  log_group_name = aws_cloudwatch_log_group.app_logs.name
  pattern        = "[timestamp, request_id, level=\"INFO\", message=\"Order created\", order_id, customer_id, amount]"

  metric_transformation {
    name      = "OrdersCreated"
    namespace = "Ecommerce/Business"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "payment_success" {
  name           = "${var.ecommerce}-payment-success"
  log_group_name = aws_cloudwatch_log_group.app_logs.name
  pattern        = "[timestamp, request_id, level=\"INFO\", message=\"Payment successful\", order_id, amount]"

  metric_transformation {
    name      = "PaymentsSuccessful"
    namespace = "Ecommerce/Business"
    value     = "1"
  }
}

# Alarma para métricas de negocio
resource "aws_cloudwatch_metric_alarm" "high_order_volume" {
  alarm_name          = "${var.ecommerce}-high-order-volume"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "OrdersCreated"
  namespace           = "Ecommerce/Business"
  period              = "300"
  statistic           = "Sum"
  threshold           = "100"
  alarm_description   = "High order volume detected - Black Friday scenario"
  alarm_actions       = [aws_sns_topic.alerts.arn]
}

