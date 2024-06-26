resource "aws_vpc_endpoint_service" "ldap_private_link_svc" {
  acceptance_required = false
  network_load_balancer_arns = [
    aws_lb.ldap_nlb.arn
  ]

  supported_ip_address_types = [
    local.ip_addr_type_ipv4
  ]

  tags = merge(
    {
      "Name" : "Private link service for LDAP Instance"
    },
    var.general_tags
  )
}
