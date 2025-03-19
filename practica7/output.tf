output "ec2_public_ip" {
  description = "ip publica de la instancia"
  value       = [for instance in aws_instance.public_instance : instance.public_ip]
}
