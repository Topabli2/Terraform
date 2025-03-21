resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public subnet_temp-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "Private subnet_temp-${local.sufix}"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

# Route table

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public custom rute table(CRT)-${local.sufix}"
  }
}

# Associaton route table with subnet
resource "aws_route_table_association" "crt_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

#Security group

resource "aws_security_group" "sg_public_instance" {
  name        = "Public instance sg"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  tags = {
    Name = "allow_SSH-${local.sufix}"
  }
}
# inbound
resource "aws_vpc_security_group_ingress_rule" "allow_SSH_ipv4" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = var.sg_ingress_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_HTTP_ipv4" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = var.sg_ingress_cidr
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_HTTPS_ipv4" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = var.sg_ingress_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# outbound
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_public_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

