resource "aws_security_group" "sg_for_ldap_vpc_endpoint" {
  vpc_id = module.basic_network.vpc_id

  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "ldap_vpc_endpoint" {
  vpc_id            = module.basic_network.vpc_id
  service_name      = module.ldap_instance.ldap_private_link_svc_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.sg_for_ldap_vpc_endpoint.id
  ]

  subnet_ids = [
    module.basic_network.private_subnet_id
  ]

  tags = var.general_tags
}
