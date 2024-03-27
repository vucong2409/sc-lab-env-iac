// Shared EFS and mountpoint. Use for sharing self signed cert between LDAP & Client
// Temporary set to allow all.
resource "aws_security_group" "sg_for_nfs_ldap_vpc" {
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
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
  security_groups = [aws_security_group.sg_for_nfs_ldap_vpc.id]
}
