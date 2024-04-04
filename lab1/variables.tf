variable "vpc_cidr" {
  type        = string
  description = "CIDR of application VPC."
}

variable "ldap_vpc_cidr" {
  type        = string
  description = "CIDR of LDAP VPC."
}

variable "vpc_region" {
  type        = string
  description = "Region to spawn 2 VPC into."
}

variable "subnet_az" {
  type        = string
  description = "Availability zone to spawn 2 VPC into."
}

variable "owner_public_key" {
  type        = string
  description = "Public key to add to EC2 instance."
}

variable "general_tags" {
  type        = map(string)
  description = "Tags to apply for all resources inside this module."
}
