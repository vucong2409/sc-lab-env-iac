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

resource "aws_vpc_peering_connection" "ldap_app_vpc_peering" {
  vpc_id = module.basic_network.vpc_id
  peer_vpc_id = module.ldap_vpc.vpc_id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  auto_accept = true
}
