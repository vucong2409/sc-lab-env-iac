resource "aws_network_interface" "public_eth_nat_instance" {
  count = local.count_nat_instance_resources

  subnet_id         = aws_subnet.main_public_subnet.id
  security_groups   = [aws_security_group.sg_for_nat_instance[0].id]
  source_dest_check = false

  tags = var.general_tags
}

resource "aws_network_interface" "private_eth_nat_instance" {
  count = local.count_nat_instance_resources

  subnet_id         = aws_subnet.main_private_subnet.id
  security_groups   = [aws_security_group.sg_for_nat_instance[0].id]
  source_dest_check = false

  tags = var.general_tags
}

resource "aws_instance" "nat_instance" {
  count = local.count_nat_instance_resources

  instance_type = local.ec2_instance_type_t2_micro
  ami           = local.ec2_instance_rhel_8_ami
  key_name      = var.ec2_keypair_name
  user_data     = file("${path.module}/resources/user-data/nat-user-data.sh")

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.public_eth_nat_instance[0].id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.private_eth_nat_instance[0].id
    device_index         = 1
  }

  tags = merge({
    "Name" = "NAT Instance"
  }, var.general_tags)
}
