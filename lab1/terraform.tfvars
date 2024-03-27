vpc_cidr                 = "10.0.0.0/16"
vpc_region               = "ap-southeast-1"
public_subnet_cidr       = "10.0.0.0/24"
private_subnet_cidr      = "10.0.1.0/24"
ldap_vpc_cidr            = "192.168.0.0/16"
public_ldap_subnet_cidr  = "192.168.0.0/24"
private_ldap_subnet_cidr = "192.168.1.0/24"
subnet_az                = "ap-southeast-1a"
owner_public_key         = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIMHHbm2am5SGTI8Ra/1Og86HrB373zPxFB8wU8bySc vucong2409@gmail.com"
general_tags = {
  "owner" = "lab1"
}
