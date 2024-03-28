// Allow all traffic from internal VPC.
// Allow SSH from internet.
resource "aws_security_group" "sg_for_nat" {
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = module.basic_network.vpc_id

  tags = var.general_tags
}


// 2 Network interface in each subnet for proxy instance
resource "aws_network_interface" "public_eth_nat" {
  subnet_id         = module.basic_network.public_subnet_id
  security_groups   = [aws_security_group.sg_for_nat.id]
  source_dest_check = false

  tags = var.general_tags
}

resource "aws_network_interface" "private_eth_nat" {
  subnet_id         = module.basic_network.private_subnet_id
  security_groups   = [aws_security_group.sg_for_nat.id]
  source_dest_check = false

  tags = var.general_tags
}

resource "aws_eip" "nat_eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.public_eth_nat.id
  associate_with_private_ip = aws_network_interface.public_eth_nat.private_ip
}

// NAT
resource "aws_instance" "nat" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  key_name      = aws_key_pair.main_ec2_keypair.key_name
  user_data     = file("resources/user-data/nat-user-data.sh")
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.public_eth_nat.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.private_eth_nat.id
    device_index         = 1
  }

  tags = merge({
    "Name" = "NAT Instance"
  }, var.general_tags)
}
