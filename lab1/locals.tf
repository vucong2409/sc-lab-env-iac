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
  connectivity_type_public  = "public"
  connectivity_type_private = "private"
}

locals {
  domain_vpc = "vpc"
}

locals {
  ec2_instance_type_t2_micro = "t2.micro"
  ec2_instance_type_t3_micro = "t3.micro"

  ec2_instance_rhel_8_ami = "ami-09b1e8fc6368b8a3a"
}

locals {
  port_neg_1        = -1
  port_0            = 0
  port_ssh          = 22
  port_http_server  = 80
  port_ldap         = 389
  port_https_server = 443
  port_ldaps        = 636
}

locals {
  cidr_all = "0.0.0.0/0"
}

locals {
  endpoint_squld_proxy = format("http://%s:3128", aws_network_interface.proxy_private_eth.private_dns_name)
  endpoint_ldap_server = aws_vpc_endpoint.ldap_vpc_endpoint.dns_entry[0]["dns_name"]
}

locals {
  arn_policy_cw_agent_server = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  arn_policy_cw_agent_admin  = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
}

locals {
  vpc_endpoint_type_interface = "Interface"
  vpc_endpoint_type_gw_lb     = "GatewayLoadBalancer"
  vpc_endpoint_type_gw        = "Gateway"
}
