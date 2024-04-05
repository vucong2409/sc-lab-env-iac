resource "aws_cloudwatch_dashboard" "ec2_monitor_dashboard" {
  dashboard_name = var.ec2_dashboard_name
  dashboard_body = templatefile(
    "${path.module}/resources/app-cw-dashboard.json.tftpl",
    {
      app_private_dns_name = var.ec2_hostname,
      app_instance_id      = var.ec2_id
    }
  )
}
