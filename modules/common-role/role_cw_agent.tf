resource "aws_iam_role" "ec2_cw_agent" {
  name               = local.role_name_ec2_cw_agent
  description        = "Role for EC2 to publish logs & metrics to CW"
  assume_role_policy = file("${path.module}/resources/ec2-cw-role.json")
}

resource "aws_iam_role_policy_attachment" "ec2_cw_role_policy_attachment" {
  role       = aws_iam_role.ec2_cw_agent.name
  policy_arn = local.arn_policy_cw_agent_server
}

resource "aws_iam_role_policy_attachment" "ec2_cw_role_policy_attachment_2" {
  role       = aws_iam_role.ec2_cw_agent.name
  policy_arn = local.arn_policy_cw_agent_admin
}
