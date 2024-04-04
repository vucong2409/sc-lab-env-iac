resource "aws_instance" "ldap_proxy" {
  instance_type = local.ec2_instance_type_t2_micro
  ami           = local.ec2_instance_rhel_8_ami
  key_name      = var.ec2_key_name

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  security_groups = [
    aws_security_group.sg_for_jumphost.id
  ]

  subnet_id                   = var.proxy_subnet_id
  associate_public_ip_address = true

  tags = merge({
    "Name" = "LDAP proxy"
  }, var.general_tags)
}
