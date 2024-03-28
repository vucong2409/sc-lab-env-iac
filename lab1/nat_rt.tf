resource "aws_route_table" "private_subnet_to_nat_rt" {
  vpc_id = module.basic_network.vpc_id

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.private_eth_nat.id
  }
}

resource "aws_route_table_association" "private_subnet_to_nat_rt_assoc" {
  subnet_id      = module.basic_network.private_subnet_id
  route_table_id = aws_route_table.private_subnet_to_nat_rt.id
}
