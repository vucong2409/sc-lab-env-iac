// Since this module doesn't have NAT Gateway/Instance, user should handle private route table association themself.
resource "aws_route_table" "main_public_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = var.general_tags
}
