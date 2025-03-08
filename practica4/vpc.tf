resource "aws_vpc" "vpc_virginia" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "VPC_VIRGINIA"
    env  = "Dev"
  }
  provider = aws.virginia
}

resource "aws_vpc" "vpc_ohio" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "VPC_OHIO"
    env  = "Dev"
  }
  provider = aws.ohio
}
