variable "resource_region" {
  type        = string
  description = <<EOT
  Region of the resources.
  EOT

  validation {
    condition     = can(regex("[a-z][a-z]-[a-z]+-[1-9]", var.vpc_region))
    error_message = "Must be valid AWS Region names."
  }
}


variable "general_tags" {
  type = map(string)
}
