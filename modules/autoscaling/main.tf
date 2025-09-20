# Launch Template para las instancias
resource "aws_launch_template" "app" {
  name_prefix   = "${var.ecommerce}-app-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    ecommerce = var.ecommerce
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name     = "${var.ecommerce}-app"
      Proyecto = var.ecommerce
    }
  }

  tags = {
    Name     = "${var.ecommerce}-launch-template"
    Proyecto = var.ecommerce
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app" {
  name                = "${var.ecommerce}-asg"
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [var.target_group_arn]
  health_check_type   = "ELB"
  health_check_grace_period = 300

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.ecommerce}-asg"
    propagate_at_launch = false
  }

  tag {
    key                 = "Proyecto"
    value               = var.ecommerce
    propagate_at_launch = true
  }
}

# CloudWatch Alarms para escalado
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.ecommerce}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${var.ecommerce}-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app.name
  }
}

# Políticas de escalado
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.ecommerce}-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.ecommerce}-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app.name
}

# Política de escalado basada en request count (para Black Friday)
resource "aws_autoscaling_policy" "scale_up_requests" {
  name                   = "${var.ecommerce}-scale-up-requests"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 180
  autoscaling_group_name = aws_autoscaling_group.app.name
}

# Alarma para request count alto (Black Friday)
resource "aws_cloudwatch_metric_alarm" "request_count_high" {
  alarm_name          = "${var.ecommerce}-request-count-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1000"
  alarm_description   = "High request count - Black Friday scenario"
  alarm_actions       = [aws_autoscaling_policy.scale_up_requests.arn]

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
}

