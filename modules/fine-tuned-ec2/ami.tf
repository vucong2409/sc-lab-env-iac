// Get the latest RHEL 9 AMI
// Only AMI with id ami-09b1e8fc6368b8a3a is available for free tier.
// TODO: Change to dynamic query
// See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "rhel9" {
  most_recent = true
  # Redhat owner ID
  owners = ["amazon"]

  filter {
    name   = "image-id"
    values = ["ami-09b1e8fc6368b8a3a"]
  }

  filter {
    name   = "platform-details"
    values = ["Red Hat Enterprise Linux"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
