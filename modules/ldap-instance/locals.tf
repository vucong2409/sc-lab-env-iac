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
  ip_addr_type_ipv4 = "ipv4"
  ip_addr_type_ipv6 = "ipv6"
}

locals {
  lb_type_application = "application"
  lb_type_network     = "network"
  lb_type_gateway     = "gateway"
}

locals {
  dns_routing_policy_only_inter_az = "availability_zone_affinity"
  dns_routing_policy_any_az        = "any_availability_zone"
  dns_routing_policy_partial_az    = "partial_availability_zone_affinity"
}

locals {
  tg_action_forward        = "forward"
  tg_action_redirect       = "redirect"
  tg_action_fixed_response = "fixed-response"
}

locals {
  tg_type_instance = "instance"
  tg_type_ip       = "ip"
  tg_type_lambda   = "lambda"
  tg_type_alb      = "alb"
}

locals {
  ssm_param_type_string        = "String"
  ssm_param_type_string_list   = "StringList"
  ssm_param_type_secure_string = "SecureString"
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
  vpc_endpoint_type_interface = "Interface"
  vpc_endpoint_type_gw_lb     = "GatewayLoadBalancer"
  vpc_endpoint_type_gw        = "Gateway"
}
