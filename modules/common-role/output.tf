output "instance_profile_name_ec2_cw_agent" {
  value       = local.instance_profile_name_ec2_cw_agent
  description = "Instance profile name for instance need to send log to Cloudwatch."
}

output "role_name_ec2_cw_agent" {
  value       = local.role_name_ec2_cw_agent
  description = "Role name for application need to send log to Cloudwatch."
}
