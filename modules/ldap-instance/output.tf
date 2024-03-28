output "ldap_nlb_id" {
  value = aws_lb.ldap_nlb.id
}

output "ldap_nlb_arn" {
  value = aws_lb.ldap_nlb.arn
}

output "ldap_nlb_dns_endpoint" {
  value = aws_lb.ldap_nlb.dns_name
}

output "ldap_private_link_svc_id" {
  value = aws_vpc_endpoint_service.ldap_private_link_svc.id
}

output "ldap_private_link_svc_arm" {
  value = aws_vpc_endpoint_service.ldap_private_link_svc.arn
}

output "ldap_private_link_svc_name" {
  value = aws_vpc_endpoint_service.ldap_private_link_svc.service_name
}
