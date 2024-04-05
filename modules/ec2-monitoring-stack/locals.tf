locals {
  metric_namespace = "CWAgent"
}

locals {
  metric_name_cpu_usage_idle = "cpu_usage_idle"
  metric_name_mem_percent    = "mem_used_percent"
  metric_name_disk_io_time   = "io_time"
}

locals {
  metric_static_avg          = "Average"
  metric_static_sample_count = "SampleCount"
  metric_static_sum          = "Sum"
  metric_static_min          = "Minimum"
  metric_static_max          = "Maximum"
}

locals {
  comparison_operator_greater_or_equal = "GreaterThanOrEqualToThreshold"
  comparison_operator_greater          = "GreaterThanThreshold"
  comparison_operator_less             = "LessThanThreshold"
  comparison_operator_less_or_equal    = "LessThanOrEqualToThreshold"
}

locals {
  name_alert_cpu = format("%s-cpu-idle-less-than-20", var.ec2_hostname)
  name_alert_mem = format("%s-mem-greater-than-40", var.ec2_hostname)
}
