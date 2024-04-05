resource "aws_instance" "app" {
  instance_type = local.ec2_instance_type_t2_micro
  ami           = local.ec2_instance_rhel_8_ami
  subnet_id     = module.app_vpc.private_subnet_id
  key_name      = aws_key_pair.main_ec2_keypair.key_name
  user_data = templatefile(
    "resources/user-data/app-user-data.sh.tftpl",
    {
      squid_proxy_addr         = local.endpoint_squld_proxy
      ldap_server_dns_endpoint = local.endpoint_ldap_server
    }
  )
  iam_instance_profile = module.common_role.instance_profile_name_ec2_cw_agent
  source_dest_check    = true
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }
  security_groups = [aws_security_group.sg_for_proxy.id]

  tags = merge({
    "Name" = "App Instance"
  }, var.general_tags)

  depends_on = [module.app_vpc, aws_instance.proxy, module.ldap_instance]
}
