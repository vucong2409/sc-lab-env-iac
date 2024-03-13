# Alert

# SNS topic for sending alert
resource "aws_sns_topic" "cw_alert_topic" {
  name = "cw-alert-topic"
}

resource "aws_sns_topic_subscription" "cw_alert_topic_email_sub" {
  topic_arn = aws_sns_topic.cw_alert_topic.arn
  protocol  = "email"
  endpoint  = "vucong2409@gmail.com"
}

# Memory alert for application instance (>40%)
resource "aws_cloudwatch_metric_alarm" "app_memory_alert" {
  alarm_name  = "app-ec2-mem-greater-than-40"
  namespace   = "CWAgent"
  metric_name = "mem_used_percent"
  dimensions = {
    "host" = aws_instance.app.private_dns
  }

  comparison_operator = "GreaterThanOrEqualToThreshold"

  statistic          = "Average"
  period             = 10
  threshold          = 40
  evaluation_periods = 2

  alarm_actions = [aws_sns_topic.cw_alert_topic.arn]

  depends_on = [aws_instance.app]
}

# Dashboard
resource "aws_cloudwatch_dashboard" "app_monitor_dashboard" {
  dashboard_name = "AppResourceDashboard"
  dashboard_body = templatefile(
    "resources/other/app-cw-dashboard.json.tftpl",
    {
      app_private_dns_name = aws_instance.app.private_dns
      app_instance_id      = aws_instance.app.id
    }
  )
}
