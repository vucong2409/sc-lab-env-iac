resource "aws_instance" "ldap_jumphost" {
  instance_type = local.ec2_instance_type_t2_micro
  ami           = local.ec2_instance_rhel_8_ami
  key_name      = aws_key_pair.main_ec2_keypair.key_name

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  security_groups = [
    aws_security_group.sg_for_jumphost.id
  ]

  subnet_id                   = module.ldap_vpc.public_subnet_id
  associate_public_ip_address = true

  tags = merge({
    "Name" = "LDAP Jumphost"
  }, var.general_tags)
}
