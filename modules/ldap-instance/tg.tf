resource "aws_lb_target_group" "ldap_tg" {
  port = 389
  protocol = "TCP"
  target_type = "instance"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group" "ldaps_tg" {
  port = 636
  protocol = "TCP"
  target_type = "instance"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "ldap_tg_attachment" {
  target_group_arn = aws_lb_target_group.ldap_tg.arn
  target_id = aws_instance.ldap.id
  port = 389
}

resource "aws_lb_target_group_attachment" "ldaps_tg_attachment" {
  target_group_arn = aws_lb_target_group.ldaps_tg.arn
  target_id = aws_instance.ldap.id
  port = 636
}
