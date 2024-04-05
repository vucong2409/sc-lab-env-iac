locals {
  arn_policy_cw_agent_server = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  arn_policy_cw_agent_admin  = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
}

locals {
  role_name_ec2_cw_agent = "ec2_cw_agent"
}

locals {
  instance_profile_name_ec2_cw_agent = "ec2_cw_instance_profile"
}
