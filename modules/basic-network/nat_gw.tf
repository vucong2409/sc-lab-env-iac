resource "aws_nat_gateway" "main_internet_nat_gw" {
  count             = local.count_nat_gw_resources
  connectivity_type = local.connectivity_type_public

  subnet_id     = aws_subnet.main_public_subnet.id
  allocation_id = aws_eip.nat_gateway_eip[0].id

  tags = var.general_tags
}
