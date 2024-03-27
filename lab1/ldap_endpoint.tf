# Create NLB and related resources (TG/SG/attachments/...)
resource "aws_security_group" "sg_for_ldap_nlb" {
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = module.ldap_vpc.vpc_id
  tags   = var.general_tags
}

resource "aws_lb" "ldap_nlb" {
  load_balancer_type = "network"
  internal           = true

  # Core settings
  ip_address_type = "ipv4"
  subnets = [
    module.ldap_vpc.private_subnet_id
  ]
  security_groups = [
    aws_security_group.sg_for_ldap.id
  ]

  # Other settings
  dns_record_client_routing_policy = "availability_zone_affinity"
  enable_cross_zone_load_balancing = false
  enable_deletion_protection       = false
}

resource "aws_lb_target_group" "ldap_tg" {
  port        = 389
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = module.ldap_vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "ldap_tg_attachment" {
  target_group_arn = aws_lb_target_group.ldap_tg.arn
  target_id        = aws_instance.ldap.id
  port             = 389
}
