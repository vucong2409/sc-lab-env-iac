resource "aws_sns_topic" "cw_alert_topic" {
  name = "cw-alert-topic"
}

resource "aws_sns_topic_subscription" "cw_alert_topic_email_sub" {
  topic_arn = aws_sns_topic.cw_alert_topic.arn
  protocol  = local.sns_sub_protocol_email
  endpoint  = var.alert_receiver_email
}

module "app_monitoring_stack" {
  source             = "../modules/ec2-monitoring-stack"
  resource_region    = var.vpc_region
  alert_topic_arn    = aws_sns_topic.cw_alert_topic.arn
  ec2_dashboard_name = local.dashboard_name_ec2_app
  ec2_hostname       = aws_instance.app.private_dns
  ec2_id             = aws_instance.app.id
}
