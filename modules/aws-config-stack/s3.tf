resource "aws_s3_bucket" "default_config_backup_bucket" {
  bucket = var.backup_s3_bucket_name
  force_destroy = true

  tags = merge({
    "Name" : "Main AWS Config backup bucket"
  }, var.general_tags)
}
