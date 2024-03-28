// Open port 22 (SSH) + ICMP only
// Since security groups are stateful, we only need to define ingress rules.
// For ICMP type number, refer to IANA documentation:
// https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
// -1 in from_port/to_port mean all icmp type.

resource "aws_security_group" "sg_for_normal_instance" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
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

  tags = var.general_tags
}

// Open port 80/tcp + 443/tcp only.
resource "aws_security_group" "sg_for_web_server" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.general_tags
}

// Allow all traffic from internal VPC.
// Allow SSH from internet.
resource "aws_security_group" "sg_for_nat_instance" {
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
  vpc_id = aws_vpc.main_vpc.id

  tags = var.general_tags
}
