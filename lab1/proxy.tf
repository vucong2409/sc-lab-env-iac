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


resource "aws_network_interface" "proxy_private_eth" {
  subnet_id         = module.basic_network.private_subnet_id
  security_groups   = [aws_security_group.sg_for_proxy.id]
  source_dest_check = false

  tags = var.general_tags
}


// Proxy
resource "aws_instance" "proxy" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  key_name      = aws_key_pair.main_ec2_keypair.key_name
  user_data     = file("resources/proxy-user-data.sh")
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.proxy_private_eth.id
    device_index         = 0
  }

  tags = merge({
    "Name" = "Proxy Instance"
  }, var.general_tags)
}
