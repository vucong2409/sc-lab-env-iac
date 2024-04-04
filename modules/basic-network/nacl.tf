// Allow all traffic.
// Since those rules are allow all, we set their number as big as possible
// to avoid any more specific rule overrided by this.

// 0 in origin port/destination port mean all.
resource "aws_network_acl" "nacl_allow_all" {
  vpc_id = aws_vpc.main_vpc.id


  ingress {
    protocol   = local.protocol_all
    rule_no    = 32766
    action     = local.action_allow
    cidr_block = local.cidr_all
    from_port  = local.port_0
    to_port    = local.port_0
  }

  egress {
    protocol   = local.protocol_all
    rule_no    = 32766
    action     = local.action_allow
    cidr_block = local.cidr_all
    from_port  = local.port_0
    to_port    = local.port_0
  }

  tags = merge({
    "Name" = format("NACL allow all access of %s", var.vpc_name)
    },
  var.general_tags)
}

// Allow all local traffic, block all other traffic
resource "aws_network_acl" "nacl_allow_local_only" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol   = local.protocol_all
    rule_no    = 32766
    action     = local.action_deny
    cidr_block = local.cidr_all
    from_port  = local.port_0
    to_port    = local.port_0
  }

  egress {
    protocol   = local.protocol_all
    rule_no    = 32766
    action     = local.action_deny
    cidr_block = local.cidr_all
    from_port  = local.port_0
    to_port    = local.port_0
  }

  ingress {
    protocol   = local.protocol_all
    rule_no    = 100
    action     = local.action_allow
    cidr_block = aws_vpc.main_vpc.cidr_block
    from_port  = local.port_0
    to_port    = local.port_0
  }

  egress {
    protocol   = local.protocol_all
    rule_no    = 100
    action     = local.action_allow
    cidr_block = aws_vpc.main_vpc.cidr_block
    from_port  = local.port_0
    to_port    = local.port_0
  }

  tags = merge({
    "Name" = format("NACL allow access from local only of %s", var.vpc_name)
    },
  var.general_tags)
}
