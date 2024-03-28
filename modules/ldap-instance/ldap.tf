resource "aws_network_interface" "ldap_private_eth" {
  subnet_id         = var.subnet_id
  security_groups   = [aws_security_group.sg_for_ldap.id]
  source_dest_check = true

  tags = merge({
    "Name" = "Private Interface for LDAP Instance"
  }, var.general_tags)
}

resource "aws_instance" "ldap" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  key_name      = var.ec2_key_name

  user_data = templatefile(
    "resources/user-data/ldap-user-data.sh.tftpl",
    {
      ldap_root_password = random_password.directory_root_password.result
    }
  )

  iam_instance_profile = var.ec2_instance_profile_name

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.ldap_private_eth.id
    device_index         = 0
  }

  tags = merge({
    "Name" = "LDAP Instance"
  }, var.general_tags)
}
