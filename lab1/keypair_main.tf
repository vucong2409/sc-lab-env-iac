resource "aws_key_pair" "main_ec2_keypair" {
  key_name   = "ec2-sc-lab-keypair"
  public_key = var.owner_public_key
}
