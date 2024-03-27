// Shared EFS and mountpoint. Use for sharing self signed cert between LDAP & Client
resource "aws_security_group" "sg_for_nfs" {
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
  vpc_id = module.ldap_vpc.vpc_id
  tags   = var.general_tags
}

resource "aws_efs_file_system" "ldap_efs" {
  availability_zone_name = var.subnet_az

  tags = var.general_tags
}

# Create mount target for each VPC
resource "aws_efs_mount_target" "ldap_vpc_efs_mount_target" {
  file_system_id  = aws_efs_file_system.ldap_efs.id
  subnet_id       = module.ldap_vpc.private_subnet_id
  security_groups = [aws_security_group.sg_for_nfs.id]
}

resource "aws_efs_mount_target" "app_vpc_efs_mount_target" {
  file_system_id  = aws_efs_file_system.ldap_efs.id
  subnet_id       = module.basic_network.private_subnet_id
  security_groups = [aws_security_group.sg_for_nfs.id]
}
