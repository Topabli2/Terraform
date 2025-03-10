resource "aws_instance" "public_instance" {
  ami                    = "ami-08b5b3a93ed654d19"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

  # lifecycle {
  #   create_before_destroy = true 
  # }   
  #Esta clausula permite que antes de que terraform destruya esta instancia para volver 
  #a crearla en otra subnet, la crea primero en esa subner y luego borra la otra

  # lifecycle {
  #   prevent_destroy = true
  # }
  #Evita que se elimine este recuros por lo que nos arrojara un mensaje de error si por ejemplo quisieramos cambiarlo de subnet

  # lifecycle {
  #   ignore_changes = [
  #     ami,
  #     subnet_id
  #     ]
  # }
  # Sirve para ignorar cambios en especificos

  # lifecycle {
  #   replace_triggered_by = [ 
  #     replace_triggered_by
  #    ]
  # }
  # Dispara un mensaje cuando se hace algun cambio al recurso selañalado
}


