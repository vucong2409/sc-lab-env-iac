resource "aws_vpc_endpoint" "ldap_vpc_endpoint" {
  vpc_id            = module.app_vpc.vpc_id
  service_name      = module.ldap_instance.ldap_private_link_svc_name
  vpc_endpoint_type = local.vpc_endpoint_type_interface

  security_group_ids = [
    aws_security_group.sg_for_ldap_vpc_endpoint.id
  ]

  subnet_ids = [
    module.app_vpc.private_subnet_id
  ]

  tags = var.general_tags
}
