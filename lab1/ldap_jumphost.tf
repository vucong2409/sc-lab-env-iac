resource "aws_security_group" "sg_for_jumphost" {
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.ldap_vpc.vpc_id

  tags = var.general_tags
}

resource "aws_instance" "ldap_jumphost" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  key_name      = aws_key_pair.main_ec2_keypair.key_name

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  security_groups = [
    aws_security_group.sg_for_jumphost.id
  ]

  subnet_id                   = module.ldap_vpc.public_subnet_id
  associate_public_ip_address = true

  tags = merge({
    "Name" = "LDAP Jumphost"
  }, var.general_tags)
}
