// Allow all traffic.
// Since those rules are allow all, we set their number as big as possible
// to avoid any more specific rule overrided by this.

// 0 in origin port/destination port mean all.
resource "aws_network_acl" "nacl_allow_all" {
  vpc_id = aws_vpc.main_vpc.id


  ingress {
    protocol   = "all"
    rule_no    = 32766
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "all"
    rule_no    = 32766
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = var.general_tags
}

// Allow all local traffic, block all other traffic
resource "aws_network_acl" "nacl_allow_local_only" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol   = "all"
    rule_no    = 32766
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "all"
    rule_no    = 32766
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_vpc.main_vpc.cidr_block
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_vpc.main_vpc.cidr_block
    from_port  = 0
    to_port    = 0
  }

  tags = var.general_tags
}
