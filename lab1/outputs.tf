output "endpoint_ldap_server" {
  value       = local.endpoint_ldap_server
  description = <<EOT
  DNS Endpoint of LDAP Server.
  Please notice that this address only accessible from application VPC.
  EOT
}
