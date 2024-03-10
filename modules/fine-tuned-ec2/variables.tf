variable "ec2_region" {
  type = string
}

variable "sg_id" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "user_data" {
  type = string
}

variable "key_name" {
  type = string
}

variable "general_tags" {
  type = map(string)
}
