output "ldap_nlb_id" {
  value = aws_lb.ldap_nlb.id
  description = "ID of LDAP NLB."
}

output "ldap_nlb_arn" {
  value = aws_lb.ldap_nlb.arn
  description = "ARN of LDAP NLB"
}

output "ldap_nlb_dns_endpoint" {
  value = aws_lb.ldap_nlb.dns_name
  description = "DNS Endpoint of LDAP NLB"
}

output "ldap_private_link_svc_id" {
  value = aws_vpc_endpoint_service.ldap_private_link_svc.id
  description = "ID of LDAP Private link Service"
}

output "ldap_private_link_svc_arm" {
  value = aws_vpc_endpoint_service.ldap_private_link_svc.arn
  description = "ARN of LDAP Private link Service"
}

output "ldap_private_link_svc_name" {
  value = aws_vpc_endpoint_service.ldap_private_link_svc.service_name
  description = "Name of LDAP Private link Service"
}
