resource "aws_lb" "ldap_nlb" {
  load_balancer_type = local.lb_type_network
  internal           = var.lb_internal

  # Core settings
  ip_address_type = local.ip_addr_type_ipv4
  subnets = [
    var.subnet_id
  ]
  security_groups = [
    aws_security_group.sg_for_ldap_nlb.id
  ]

  # Other settings
  dns_record_client_routing_policy = local.dns_routing_policy_only_inter_az
  enable_cross_zone_load_balancing = false
  enable_deletion_protection       = false

  tags = merge(
    {
      "Name" = "NLB for LDAP Instance"
    },
    var.general_tags
  )
}

resource "aws_lb_listener" "ldap_nlb_listener" {
  load_balancer_arn = aws_lb.ldap_nlb.arn
  port              = local.port_ldap
  protocol          = upper(local.protocol_tcp)

  default_action {
    type             = local.tg_action_forward
    target_group_arn = aws_lb_target_group.ldap_tg.arn
  }
}

resource "aws_lb_listener" "ldaps_nlb_listener" {
  load_balancer_arn = aws_lb.ldap_nlb.arn
  port              = local.port_ldaps
  protocol          = upper(local.protocol_tcp)

  default_action {
    type             = local.tg_action_forward
    target_group_arn = aws_lb_target_group.ldaps_tg.arn
  }
}
