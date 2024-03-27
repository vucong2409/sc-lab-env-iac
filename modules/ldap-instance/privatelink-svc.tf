resource "aws_vpc_endpoint_service" "ldap_private_link_svc" {
  acceptance_required = false
  network_load_balancer_arns = [
    aws_lb.ldap_nlb.arn
  ]

  supported_ip_address_types = [
    "ipv4"
  ]
}
