variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "subnet_az" {
  type = string
}

variable "general_tags" {
  type = map(string)
}
