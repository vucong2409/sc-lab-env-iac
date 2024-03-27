# Define required resource for LDAP (VPC/NFS for sharing cert/...)
module "ldap_vpc" {
  source              = "../modules/basic-network-with-nat"
  vpc_region          = var.vpc_region
  vpc_cidr            = var.ldap_vpc_cidr
  public_subnet_cidr  = var.public_ldap_subnet_cidr
  private_subnet_cidr = var.private_ldap_subnet_cidr
  subnet_az           = var.subnet_az
  general_tags        = var.general_tags
}
