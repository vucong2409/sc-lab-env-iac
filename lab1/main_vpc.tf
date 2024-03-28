module "basic_network" {
  source                = "../modules/basic-network-with-nat-instance"
  vpc_region            = var.vpc_region
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  subnet_az             = var.subnet_az
  nat_instance_key_name = aws_key_pair.main_ec2_keypair.key_name
  general_tags          = var.general_tags
}
