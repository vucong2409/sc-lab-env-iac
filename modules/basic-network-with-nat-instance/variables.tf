variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "vpc_region" {
  type = string
}

variable "subnet_az" {
  type = string
}

variable "nat_instance_key_name" {
  type = string
}

variable "general_tags" {
  type = map(string)
}
