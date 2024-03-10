// Get the latest RHEL 9 AMI
// RHEL 9 instead of 8 since only 9 is available for free tier.
// See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "rhel9" {
  most_recent = true
  # Redhat owner ID
  owners = ["309956199498"]

  filter {
    name = "name"
    values = ["RHEL-9*"]
  }

  filter {
    name = "platform"
    values = ["rhel"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
}
