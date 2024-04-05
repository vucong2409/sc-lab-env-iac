# Use this instance profile to assign to EC2 that need to emit log to CW
resource "aws_iam_instance_profile" "ec2_cw_instance_profile" {
  name = local.instance_profile_name_ec2_cw_agent
  role = aws_iam_role.ec2_cw_agent.name
}
