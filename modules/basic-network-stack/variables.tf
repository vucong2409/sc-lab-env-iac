variable "vpc_name" {
  type        = string
  description = <<EOT
  Name of the VPC.
  Other resources inside this VPC also generate name based on this VPC Name.
  EOT
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC."

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Must be a valid VPC CIDR."
  }
}

variable "vpc_region" {
  type        = string
  description = <<EOT
  Region of the VPC.
  EOT

  validation {
    condition     = can(regex("[a-z][a-z]-[a-z]+-[1-9]", var.vpc_region))
    error_message = "Must be valid AWS Region names."
  }
}

variable "subnet_az" {
  type        = string
  description = <<EOT
  Availability Zone to create subnets and related resources in.
  Since this is just a module for lab, all resources will be created inside one AZ.
  EOT
}

variable "ec2_keypair_name" {
  type        = string
  description = <<EOT
  Keypair to add into related EC2 instance (e.g. NAT Instance)
  EOT
}

variable "nat_device_type" {
  type        = number
  description = <<EOT
  Type of NAT Device for private subnet.
  0 for no NAT device (Private subnet can't access internet).
  1 for NAT Gateway.
  2 for NAT Instance (default to RHEL 8 instance with t2.micro size).
  EOT

  validation {
    condition     = var.nat_device_type > 0 && var.nat_device_type < 3
    error_message = "Invalid option for NAT device."
  }
}

variable "general_tags" {
  type = map(string)
}
