module "ldap_instance" {
  source                    = "../modules/ldap-instance"
  resource_region           = var.vpc_region
  vpc_id                    = module.ldap_vpc.vpc_id
  ldap_subnet_id            = module.ldap_vpc.private_subnet_id
  proxy_subnet_id           = module.ldap_vpc.public_subnet_id
  ec2_key_name              = aws_key_pair.main_ec2_keypair.key_name
  lb_internal               = true
  ec2_instance_profile_name = module.common_role.instance_profile_name_ec2_cw_agent
  general_tags              = var.general_tags
}
