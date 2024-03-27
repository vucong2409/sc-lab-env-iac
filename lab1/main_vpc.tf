module "basic_network" {
  source              = "../modules/basic-network"
  vpc_region          = var.vpc_region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  subnet_az           = var.subnet_az
  general_tags        = var.general_tags
}
