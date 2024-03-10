resource "aws_instance" "application_ec2" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.rhel9.id
  subnet_id     = var.subnet_id
  // Allow EC2 to get its own metadata
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }
  private_dns_name_options {
    hostname_type = "ip-name"
  }
  vpc_security_group_ids = var.sg_id
  user_data              = var.user_data
  key_name               = var.key_name
  // This is not a NAT/Proxy, so enable source/dest check options.
  source_dest_check = true
  tags              = var.general_tags
}
