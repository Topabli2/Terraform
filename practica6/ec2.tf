resource "aws_instance" "public_instance" {
  ami           = "ami-08b5b3a93ed654d19"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = data.aws_key_pair.key
}


