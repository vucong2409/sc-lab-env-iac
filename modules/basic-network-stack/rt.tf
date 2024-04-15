// Since this module doesn't have NAT Gateway/Instance, user should handle private route table association themself.
resource "aws_route_table" "main_public_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = local.cidr_all
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = merge({
    "Name" = format("Route table for public subnet of %s", var.vpc_name)
    },
  var.general_tags)
}

resource "aws_route_table" "main_private_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge({
    "Name" = format("Route table for private subnet of %s", var.vpc_name)
    },
  var.general_tags)
}

resource "aws_route" "private_subnet_to_nat_gateway" {
  count          = local.count_nat_gw_resources
  route_table_id = aws_route_table.main_private_subnet_rt.id

  destination_cidr_block = local.cidr_all
  nat_gateway_id         = aws_nat_gateway.main_internet_nat_gw[0].id
}

resource "aws_route" "private_subnet_to_nat_instance" {
  count          = local.count_nat_instance_resources
  route_table_id = aws_route_table.main_private_subnet_rt.id

  destination_cidr_block = local.cidr_all
  network_interface_id   = aws_network_interface.private_eth_nat_instance[0].id
}
