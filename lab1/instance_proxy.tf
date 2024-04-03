resource "aws_network_interface" "proxy_private_eth" {
  subnet_id         = module.app_vpc.private_subnet_id
  security_groups   = [aws_security_group.sg_for_proxy.id]
  source_dest_check = false

  tags = var.general_tags
}

// Proxy
resource "aws_instance" "proxy" {
  instance_type = local.ec2_instance_type_t2_micro
  ami           = local.ec2_instance_rhel_8_ami
  key_name      = aws_key_pair.main_ec2_keypair.key_name
  user_data = templatefile(
    "resources/user-data/proxy-user-data.sh.tftpl",
    {
      ldap_server_dns_endpoint = local.endpoint_ldap_server
    }
  )
  iam_instance_profile = aws_iam_instance_profile.ec2_cw_instance_profile.name
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.proxy_private_eth.id
    device_index         = 0
  }

  tags = merge({
    "Name" = "Proxy Instance"
  }, var.general_tags)
  depends_on = [module.ldap_instance]
}
