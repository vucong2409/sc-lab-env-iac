// Allow all traffic from internal VPC.
// Allow SSH from internet.
resource "aws_security_group" "sg_for_proxy" {
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
resource "aws_network_interface" "public_eth" {
  subnet_id         = module.basic_network.public_subnet_id
  security_groups   = [aws_security_group.sg_for_proxy.id]
  source_dest_check = false

  tags = var.general_tags
}

resource "aws_network_interface" "private_eth" {
  subnet_id         = module.basic_network.private_subnet_id
  security_groups   = [aws_security_group.sg_for_proxy.id]
  source_dest_check = false

  tags = var.general_tags
}

resource "aws_eip" "proxy_eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.public_eth.id
  associate_with_private_ip = aws_network_interface.public_eth.private_ip
}

// Create route table for private subnet to point to NAT interface
resource "aws_route_table" "private_to_nat" {
  vpc_id = module.basic_network.vpc_id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.private_eth.id
  }

  tags = var.general_tags
}

resource "aws_route_table_association" "proxy_rt_assoc" {
  subnet_id      = module.basic_network.private_subnet_id
  route_table_id = aws_route_table.private_to_nat.id
}

// NAT + Squid
resource "aws_instance" "proxy" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  key_name      = aws_key_pair.main_ec2_keypair.key_name
  user_data     = file("resources/nat-user-data.sh")
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.public_eth.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.private_eth.id
    device_index         = 1
  }

  tags = var.general_tags
}
