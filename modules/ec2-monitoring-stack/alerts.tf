resource "aws_cloudwatch_metric_alarm" "ec2_cpu_alert" {
  alarm_name  = local.name_alert_cpu
  namespace   = local.metric_namespace
  metric_name = local.metric_name_cpu_usage_idle
  dimensions = {
    "host" = var.ec2_hostname
  }

  comparison_operator = local.comparison_operator_less_or_equal
  statistic           = local.metric_static_avg
  period              = 10
  threshold           = 20
  evaluation_periods  = 2

  alarm_actions = [var.alert_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "ec2_memory_alert" {
  alarm_name  = local.name_alert_mem
  namespace   = local.metric_namespace
  metric_name = local.metric_name_mem_percent
  dimensions = {
    "host" = var.ec2_hostname
  }

  comparison_operator = local.comparison_operator_greater_or_equal
  statistic           = local.metric_static_avg
  period              = 10
  threshold           = 40
  evaluation_periods  = 2

  alarm_actions = [var.alert_topic_arn]
}
