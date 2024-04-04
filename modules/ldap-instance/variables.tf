variable "resource_region" {
  type        = string
  description = "Region to create resources in."
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC to create resources in."
}

variable "ldap_subnet_id" {
  type        = string
  description = "ID of subnet to create LDAP instance & LB in."
}

variable "proxy_subnet_id" {
  type        = string
  description = "ID of subnet to create proxy instance into."
}

variable "ec2_key_name" {
  type        = string
  description = "Name of the keypair to add into LDAP instance & LDAP proxy"
}

variable "lb_internal" {
  type        = bool
  description = <<EOT
  `true` for public facing NLB, `false` for internal NLB.
  Please make sure that if set this options to `true`, `ldap_subnet_id` must also a public subnet ID.
  EOT
}

variable "ec2_instance_profile_name" {
  type        = string
  description = <<EOT
  Instance profile for LDAP Instance.
  LDAP instance need instance profile to send log to Cloudwatch.
  EOT
}

variable "general_tags" {
  type = map(string)
}
