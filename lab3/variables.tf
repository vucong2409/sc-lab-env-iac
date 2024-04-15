variable "resource_region" {
  type        = string
  description = <<EOT
  Region of the resources.
  EOT

  validation {
    condition     = can(regex("[a-z][a-z]-[a-z]+-[1-9]", var.resource_region))
    error_message = "Must be a valid AWS Region name."
  }
}

variable "s3_bucket_name_config_backup" {
  type        = string
  description = <<EOT
  Name of the S3 bucket used as the main backup channel for AWS Config.
  This bucket will be created automatically.
  EOT

  # validation {
  #   # Regex copied from https://stackoverflow.com/questions/50480924/regex-for-s3-bucket-name
  #   condition     = can(regex("(?!(^xn--|.+-s3alias$))^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.s3_bucket_name_config_backup))
  #   error_message = <<EOT
  #   Must be a valid S3 Bucket name.
  #   See https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html.
  #   EOT
  # }
}

variable "general_tags" {
  type = map
}
