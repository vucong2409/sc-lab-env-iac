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
  count_nat_gw_resources       = var.nat_device_type == 1 ? 1 : 0
  count_nat_instance_resources = var.nat_device_type == 2 ? 1 : 0
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
  port_https_server = 443
}

locals {
  cidr_all            = "0.0.0.0/0"
  cidr_public_subnet  = cidrsubnet(var.vpc_cidr, 8, 0)
  cidr_private_subnet = cidrsubnet(var.vpc_cidr, 8, 1)
}
