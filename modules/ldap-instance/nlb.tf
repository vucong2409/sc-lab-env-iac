resource "aws_lb" "ldap_nlb" {
  load_balancer_type = "network"
  internal = var.lb_internal

  # Core settings
  ip_address_type = "ipv4"
  subnets = [
    var.subnet_id
  ]
  security_groups = [
    aws_security_group.sg_for_ldap_nlb.id
  ]

  # Other settings
  dns_record_client_routing_policy = "availability_zone_affinity"
  enable_cross_zone_load_balancing = false
  enable_deletion_protection = false
}

resource "aws_lb_listener" "ldap_nlb_listener" {
  load_balancer_arn = aws_lb.ldap_nlb.arn
  port = "389"
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ldap_tg.arn
  }
}

resource "aws_lb_listener" "ldaps_nlb_listener" {
  load_balancer_arn = aws_lb.ldap_nlb.arn
  port = "636"
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ldaps_tg.arn
  }
}
