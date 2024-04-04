resource "aws_lb_target_group" "ldap_tg" {
  port        = local.port_ldap
  protocol    = upper(local.protocol_tcp)
  target_type = local.tg_type_instance
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group" "ldaps_tg" {
  port        = local.port_ldaps
  protocol    = upper(local.protocol_tcp)
  target_type = local.tg_type_instance
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "ldap_tg_attachment" {
  target_group_arn = aws_lb_target_group.ldap_tg.arn
  target_id        = aws_instance.ldap.id
  port             = local.port_ldap
}

resource "aws_lb_target_group_attachment" "ldaps_tg_attachment" {
  target_group_arn = aws_lb_target_group.ldaps_tg.arn
  target_id        = aws_instance.ldap.id
  port             = local.port_ldaps
}
