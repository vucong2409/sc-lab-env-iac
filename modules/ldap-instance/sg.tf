// Allow SSH, LDAP and LDAPS request from internet.
resource "aws_security_group" "sg_for_ldap" {
  ingress {
    from_port   = local.port_ssh
    to_port     = local.port_ssh
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

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
  vpc_id = var.vpc_id
  tags = merge({
    "Name" = "Security Group for LDAP Instance"
  }, var.general_tags)
}

// Allow all
resource "aws_security_group" "sg_for_ldap_nlb" {
  ingress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [local.cidr_all]
  }
  vpc_id = var.vpc_id
  tags = merge({
    "Name" = "Security Group for LDAP Network Load Balancer"
  }, var.general_tags)
}
