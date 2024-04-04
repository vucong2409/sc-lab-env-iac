module "ldap_vpc" {
  source           = "../modules/basic-network"
  vpc_region       = var.vpc_region
  vpc_cidr         = var.ldap_vpc_cidr
  subnet_az        = var.subnet_az
  nat_device_type  = 1
  ec2_keypair_name = aws_key_pair.main_ec2_keypair.key_name
  general_tags     = var.general_tags
}
