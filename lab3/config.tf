module "aws-config-stack" {
  source = "../modules/aws-config-stack"
  resource_region = var.resource_region
  backup_s3_bucket_name = var.s3_bucket_name_config_backup
  general_tags = var.general_tags
}
