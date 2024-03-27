variable "resource_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ec2_key_name" {
  type = string
}

variable "ec2_instance_profile" {

}

variable "general_tags" {
  type = map(string)
}
