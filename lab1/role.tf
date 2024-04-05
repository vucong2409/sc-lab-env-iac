module "common_role" {
  source          = "../modules/common-role"
  resource_region = var.vpc_region
}
