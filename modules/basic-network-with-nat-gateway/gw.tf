resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = var.general_tags
}

// EIP for public NAT.
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main_internet_nat_gw" {
  connectivity_type = "public"
  subnet_id = aws_subnet.main_public_subnet.id
  allocation_id = aws_eip.nat_eip.id

  tags = var.general_tags
}
