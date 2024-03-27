resource "aws_route_table" "public_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  route {
    cidr_block = aws_vpc.main_vpc.cidr_block
    gateway_id = "local"
  }

  tags = var.general_tags
}

resource "aws_route_table" "private_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main_internet_nat_gw.id
  }

  route {
    cidr_block = aws_vpc.main_vpc.cidr_block
    gateway_id = "local"
  }

  tags = var.general_tags
}
