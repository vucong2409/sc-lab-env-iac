resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge({
    "Name" = format("Main IGW of %s", var.vpc_name)
    },
  var.general_tags)
}
