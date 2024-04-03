resource "aws_eip" "nat_gateway_eip" {
  count  = local.count_nat_gw_resources
  domain = local.domain_vpc

  tags = var.general_tags
}

resource "aws_eip" "nat_instance_eip" {
  count = local.count_nat_instance_resources

  domain                    = local.domain_vpc
  network_interface         = aws_network_interface.public_eth_nat_instance[0].id
  associate_with_private_ip = aws_network_interface.public_eth_nat_instance[0].private_ip

  tags = var.general_tags
}
