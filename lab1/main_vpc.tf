module "basic_network" {
  source          = "../modules/basic-network"
  vpc_region      = var.vpc_region
  vpc_cidr        = var.vpc_cidr
  subnet_az       = var.subnet_az
  nat_device_type = 2
  general_tags    = var.general_tags
}
