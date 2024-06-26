resource "aws_subnet" "main_public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = local.cidr_public_subnet
  availability_zone       = var.subnet_az
  map_public_ip_on_launch = true

  tags = merge({
    "Name" = format("Main public subnet of %s", var.vpc_name)
    },
  var.general_tags)
}

resource "aws_subnet" "main_private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = local.cidr_private_subnet
  availability_zone = var.subnet_az

  tags = merge({
    "Name" = format("Main private subnet of %s", var.vpc_name)
    },
  var.general_tags)
}

resource "aws_route_table_association" "main_public_subnet_rt_assoc" {
  subnet_id      = aws_subnet.main_public_subnet.id
  route_table_id = aws_route_table.main_public_subnet_rt.id
}

resource "aws_route_table_association" "main_private_subnet_rt_assoc" {
  subnet_id      = aws_subnet.main_private_subnet.id
  route_table_id = aws_route_table.main_private_subnet_rt.id
}

resource "aws_network_acl_association" "main_public_subnet_nacl_assoc" {
  network_acl_id = aws_network_acl.nacl_allow_all.id
  subnet_id      = aws_subnet.main_public_subnet.id
}

resource "aws_network_acl_association" "main_private_subnet_nacl_assoc" {
  network_acl_id = aws_network_acl.nacl_allow_all.id
  subnet_id      = aws_subnet.main_private_subnet.id
}
