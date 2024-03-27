// Allow all traffic from internal VPC.
// Allow SSH from internet.
// Allow LDAP query from internet.
resource "aws_security_group" "sg_for_ldap" {
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = [var.ldap_vpc_cidr]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = module.ldap_vpc.vpc_id
  tags   = var.general_tags
}

resource "aws_network_interface" "ldap_private_eth" {
  subnet_id         = module.ldap_vpc.private_subnet_id
  security_groups   = [aws_security_group.sg_for_ldap.id]
  source_dest_check = false

  tags = var.general_tags
}

// Root Directory parameter. Generated by Terraform random.
// In production, it should be Secret Manager instead of SSM parameter.
// But this is designed to run on free tier so...
resource "random_password" "directory_root_password" {
  length = 8
  // No special character to avoid error when rendering template
  special = false
}

resource "aws_ssm_parameter" "directory_root_password_param" {
  name  = "/ldap/instancepassword"
  type  = "String"
  value = random_password.directory_root_password.result
}

// LDAP
resource "aws_instance" "ldap" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  key_name      = aws_key_pair.main_ec2_keypair.key_name
  user_data = templatefile(
    "resources/user-data/ldap-user-data.sh.tftpl",
    {
      ldap_root_password = random_password.directory_root_password.result
    }
  )
  iam_instance_profile = aws_iam_instance_profile.ec2_cw_instance_profile.name
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.ldap_private_eth.id
    device_index         = 0
  }

  depends_on = [aws_route_table_association.private_subnet_rt_with_peering_ldap_vpc_assoc]

  tags = merge({
    "Name" = "LDAP Instance"
  }, var.general_tags)
}
