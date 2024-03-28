output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.main_public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.main_private_subnet.id
}

output "normal_sg_id" {
  value = aws_security_group.sg_for_normal_instance
}

output "app_sg_id" {
  value = aws_security_group.sg_for_web_server.id
}

output "main_igw_id" {
  value = aws_internet_gateway.main_igw.id
}

output "main_nat_gw_id" {
  value = aws_nat_gateway.main_internet_nat_gw.id
}
