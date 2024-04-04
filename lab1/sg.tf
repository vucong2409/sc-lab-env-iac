// Allow all traffic from internal VPC.
// Allow SSH from internet.
resource "aws_security_group" "sg_for_proxy" {
  ingress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = local.port_ssh
    to_port     = local.port_ssh
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [local.cidr_all]
  }
  vpc_id = module.app_vpc.vpc_id

  tags = var.general_tags
}

resource "aws_security_group" "sg_for_jumphost" {
  ingress {
    from_port   = local.port_ssh
    to_port     = local.port_ssh
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [local.cidr_all]
  }

  vpc_id = module.ldap_vpc.vpc_id

  tags = var.general_tags
}

resource "aws_security_group" "sg_for_ldap_vpc_endpoint" {
  vpc_id = module.app_vpc.vpc_id

  ingress {
    from_port   = local.port_ldap
    to_port     = local.port_ldap
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

  ingress {
    from_port   = local.port_ldaps
    to_port     = local.port_ldaps
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [local.cidr_all]
  }
}
