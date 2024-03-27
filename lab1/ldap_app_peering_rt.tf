resource "aws_route_table" "public_subnet_rt_with_peering_app_vpc" {
  vpc_id = module.basic_network.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.basic_network.main_igw_id
  }

  route {
    cidr_block                = var.ldap_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.ldap_app_vpc_peering.id
  }

  tags = var.general_tags
}

resource "aws_route_table" "private_subnet_rt_with_peering_app_vpc" {
  vpc_id = module.basic_network.vpc_id

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.private_eth_nat.id
  }

  route {
    cidr_block                = var.ldap_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.ldap_app_vpc_peering.id
  }

  tags       = var.general_tags
  depends_on = [aws_network_interface.private_eth_nat]
}

resource "aws_route_table" "public_subnet_rt_with_peering_ldap_vpc" {
  vpc_id = module.ldap_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.ldap_vpc.main_igw_id
  }

  route {
    cidr_block                = var.vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.ldap_app_vpc_peering.id
  }

  tags = var.general_tags
}

resource "aws_route_table" "private_subnet_rt_with_peering_ldap_vpc" {
  vpc_id = module.ldap_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.ldap_vpc.main_nat_gw_id
  }

  route {
    cidr_block                = var.vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.ldap_app_vpc_peering.id
  }

  tags = var.general_tags
}

resource "aws_route_table_association" "public_subnet_rt_with_peering_app_vpc_assoc" {
  route_table_id = aws_route_table.public_subnet_rt_with_peering_app_vpc.id
  subnet_id      = module.basic_network.public_subnet_id
}

resource "aws_route_table_association" "private_subnet_rt_with_peering_app_vpc_assoc" {
  route_table_id = aws_route_table.private_subnet_rt_with_peering_app_vpc.id
  subnet_id      = module.basic_network.private_subnet_id
}

resource "aws_route_table_association" "public_subnet_rt_with_peering_ldap_vpc_assoc" {
  route_table_id = aws_route_table.public_subnet_rt_with_peering_ldap_vpc.id
  subnet_id      = module.ldap_vpc.public_subnet_id
}

resource "aws_route_table_association" "private_subnet_rt_with_peering_ldap_vpc_assoc" {
  route_table_id = aws_route_table.private_subnet_rt_with_peering_ldap_vpc.id
  subnet_id      = module.ldap_vpc.private_subnet_id
}
