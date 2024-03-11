terraform {
  // Hard code bucket information instead of using variable since Terraform not support it.
  // See: https://github.com/hashicorp/terraform/issues/13022
  backend "s3" {
    bucket = "sc-lab-state-bucket"
    key    = "tf-state/lab-01/dev/state"
    region = "ap-southeast-1"
  }
}

resource "aws_key_pair" "main_ec2_keypair" {
  key_name   = "ec2-sc-lab-keypair"
  public_key = var.owner_public_key
}

module "basic_network" {
  source              = "../modules/basic-network"
  vpc_region          = var.vpc_region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  subnet_az           = var.subnet_az
  general_tags        = var.general_tags
}

resource "aws_instance" "app" {
  instance_type = "t2.micro"
  ami           = "ami-09b1e8fc6368b8a3a"
  subnet_id     = module.basic_network.private_subnet_id
  key_name      = aws_key_pair.main_ec2_keypair.key_name
  user_data = templatefile(
    "resources/app-user-data.sh.tftpl",
    {
      squid_proxy_addr = format("http://%s:3128", aws_network_interface.proxy_private_eth.private_dns_name)
    }
  )
  source_dest_check = true
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }
  security_groups = [aws_security_group.sg_for_proxy.id]

  tags = merge({
    "Name" = "App Instance"
  }, var.general_tags)

  depends_on = [aws_instance.nat, aws_instance.proxy]
}
