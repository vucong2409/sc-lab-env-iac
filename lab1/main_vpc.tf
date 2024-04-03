module "basic_network" {
  source           = "../modules/basic-network"
  vpc_region       = var.vpc_region
  vpc_cidr         = var.vpc_cidr
  subnet_az        = var.subnet_az
  nat_device_type  = 2
  ec2_keypair_name = aws_key_pair.main_ec2_keypair.key_name
  general_tags     = var.general_tags
}
