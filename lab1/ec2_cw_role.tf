resource "aws_iam_role" "ec2_cw_role" {
  name               = "ec2_cw_role"
  description        = "Role for EC2 to publish logs & metrics to CW"
  assume_role_policy = file("resources/other/ec2-cw-role.json")

  tags = var.general_tags
}

resource "aws_iam_role_policy_attachment" "ec2_cw_role_policy_attachment" {
  role       = aws_iam_role.ec2_cw_role.name
  policy_arn = local.arn_policy_cw_agent_server
}

resource "aws_iam_role_policy_attachment" "ec2_cw_role_policy_attachment_2" {
  role       = aws_iam_role.ec2_cw_role.name
  policy_arn = local.arn_policy_cw_agent_admin
}

# Use this instance profile to assign to EC2 that need to emit log to CW
resource "aws_iam_instance_profile" "ec2_cw_instance_profile" {
  name = "ec2_cw_instance_profile"
  role = aws_iam_role.ec2_cw_role.name
}
