resource "aws_network_interface" "public_eth_nat_interface" {
  subnet_id         = aws_subnet.main_public_subnet.id
  security_groups   = [aws_security_group.sg_for_nat_instance.id]
  source_dest_check = false

  tags = var.general_tags
}

resource "aws_network_interface" "private_eth_nat_interface" {
  subnet_id         = aws_subnet.main_private_subnet.id
  security_groups   = [aws_security_group.sg_for_nat_instance.id]
  source_dest_check = false

  tags = var.general_tags
}

resource "aws_eip" "nat_eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.public_eth_nat_interface.id
  associate_with_private_ip = aws_network_interface.public_eth_nat_interface.private_ip

  depends_on = [aws_instance.public_eth_nat_interface]
}

resource "aws_instance" "nat" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  key_name      = var.nat_instance_key_name
  user_data     = file("${path.module}/resources/user-data/nat-user-data.sh")
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.public_eth_nat_interface.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.private_eth_nat_interface.id
    device_index         = 1
  }

  tags = merge({
    "Name" = "NAT Instance"
  }, var.general_tags)
}
