resource "aws_route_table" "main_public_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = var.general_tags
}

resource "aws_route_table" "main_private_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.private_eth_nat_interface.id
  }
}
