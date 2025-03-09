resource "aws_instance" "public_instance" {
  ami           = "ami-08b5b3a93ed654d19"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  # key_name      = data.aws_key_pair.key.key_name

  # lifecycle {
  #   create_before_destroy = true 
  # }   
  #Esta clausula permite que antes de que terraform destruya esta instancia para volver 
  #a crearla en otra subnet, la crea primero en esa subner y luego borra la otra

  # lifecycle {
  #   prevent_destroy = true
  # }
  #Evita que se elimine este recuros
}


