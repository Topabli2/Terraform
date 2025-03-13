resource "aws_instance" "public_instance" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  provisioner "local-exec" {
    command = "echo instancia creada con IP ${aws_instance.public_instance.public_ip} >> datos_instancia.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo instancia ${self.public_ip} destruida >> datos_instancia.txt"
  } #self hace referencia al recurso en el que estamos codeando


  # Esto no se usa en el mundo real pero se debe saber de igual manera para el examen 
  # provisioner "remote-exec" {
  #   inline = [
  #     "echo 'hola mundo' > ~/saludo.txt"
  #   ]
  #   connection {
  #     type        = "ssh"
  #     host        = self.public_ip
  #     user        = "ec2-user"
  #     private_key = file("C:\\Users\\Pablo Vera\\.ssh\\test.pem")
  #   }
  # }

  # lifecycle {
  #   create_before_destroy = true 
  # }   
  #Esta clausula permite que antes de que terraform destruya esta instancia para volver 
  #a crearla en otra subnet, la crea primero en esa subnet y luego borra la otra

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
