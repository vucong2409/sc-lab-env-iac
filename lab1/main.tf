terraform {
  // Hard code bucket information instead of using variable since Terraform not support it.
  // See: https://github.com/hashicorp/terraform/issues/13022
  backend "s3" {
    bucket = "sc-lab-state-bucket"
    key    = "tf-state/lab-01/dev/state"
    region = "ap-southeast-1"
  }
}

module "basic-network" {
  source              = "../modules/basic-network"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  subnet_az           = var.subnet_az
  general_tags        = var.general_tags
}
