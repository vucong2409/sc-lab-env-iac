// Allow all traffic from internal VPC.
// Allow SSH from internet.
resource "aws_security_group" "sg_for_ldap" {
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

resource "aws_network_interface" "ldap_private_eth" {
  subnet_id         = module.basic_network.private_subnet_id
  security_groups   = [aws_security_group.sg_for_ldap.id]
  source_dest_check = false

  tags = var.general_tags
}

// Shared EFS and mountpoint. Use for sharing self signed cert between LDAP & Client
resource "aws_efs_file_system" "ldap_efs" {
  availability_zone_name = var.subnet_az

  tags = var.general_tags
}

resource "aws_efs_mount_target" "ldap_efs_mount_target" {
  file_system_id  = aws_efs_file_system.ldap_efs.id
  subnet_id       = module.basic_network.private_subnet_id
  security_groups = [aws_security_group.sg_for_ldap.id]
}

// LDAP
resource "aws_instance" "ldap" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  key_name      = aws_key_pair.main_ec2_keypair.key_name
  user_data = templatefile(
    "resources/user-data/ldap-user-data.sh.tftpl",
    {
      efs-dns-addr = aws_efs_file_system.ldap_efs.dns_name
    }
  )
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  network_interface {
    network_interface_id = aws_network_interface.ldap_private_eth.id
    device_index         = 0
  }

  depends_on = [aws_instance.nat, aws_instance.proxy, aws_efs_file_system.ldap_efs]

  tags = merge({
    "Name" = "LDAP Instance"
  }, var.general_tags)
}
