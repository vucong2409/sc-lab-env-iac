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
