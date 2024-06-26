// Open port 22 (SSH) + ICMP only
// Since security groups are stateful, we only need to define ingress rules.
// For ICMP type number, refer to IANA documentation:
// https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
// -1 in from_port/to_port mean all icmp type.

resource "aws_security_group" "sg_for_normal_instance" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = local.port_neg_1
    to_port     = local.port_neg_1
    protocol    = local.protocol_icmp
    cidr_blocks = [local.cidr_all]
  }

  ingress {
    from_port   = local.port_ssh
    to_port     = local.port_ssh
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [local.cidr_all]
  }

  tags = merge({
    "Name" = format("Security group for normal instance inside %s", var.vpc_name)
    },
  var.general_tags)
}

// Open port 80/tcp + 443/tcp only.
resource "aws_security_group" "sg_for_web_server" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = local.port_http_server
    to_port     = local.port_http_server
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

  ingress {
    from_port   = local.port_https_server
    to_port     = local.port_https_server
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [local.cidr_all]
  }

  tags = merge({
    "Name" = format("Security group for web server inside %s", var.vpc_name)
    },
  var.general_tags)
}

// Allow all traffic from internal VPC
// Allow SSH from internet.
resource "aws_security_group" "sg_for_nat_instance" {
  count = local.count_nat_instance_resources

  ingress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = local.port_ssh
    to_port     = local.port_ssh
    protocol    = local.protocol_tcp
    cidr_blocks = [local.cidr_all]
  }

  egress {
    from_port   = local.port_0
    to_port     = local.port_0
    protocol    = local.protocol_all
    cidr_blocks = [local.cidr_all]
  }

  vpc_id = aws_vpc.main_vpc.id

  tags = merge({
    "Name" = format("Security group for NAT instance inside %s", var.vpc_name)
    },
  var.general_tags)
}
