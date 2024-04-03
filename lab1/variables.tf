variable "vpc_cidr" {
  type = string
}

variable "ldap_vpc_cidr" {
  type = string
}

variable "public_ldap_subnet_cidr" {
  type = string
}

variable "private_ldap_subnet_cidr" {
  type = string
}

variable "vpc_region" {
  type = string
}

variable "subnet_az" {
  type = string
}

variable "owner_public_key" {
  type = string
}

variable "general_tags" {
  type = map(string)
}
