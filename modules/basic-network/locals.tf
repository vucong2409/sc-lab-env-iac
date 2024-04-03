# Common variables
locals {
  protocol_all  = "all"
  protocol_tcp  = "tcp"
  protocol_udp  = "udp"
  protocol_icmp = "icmp"
}

locals {
  action_allow = "allow"
  action_deny  = "deny"
}

locals {
  port_neg_1        = -1
  port_0            = 0
  port_ssh          = 22
  port_http_server  = 80
  port_https_server = 443
}

# Subnet CIDR
locals {
  cidr_all            = "0.0.0.0/0"
  cidr_public_subnet  = cidrsubnet(var.vpc_cidr, 8, 0)
  cidr_private_subnet = cidrsubnet(var.vpc_cidr, 8, 1)
}
