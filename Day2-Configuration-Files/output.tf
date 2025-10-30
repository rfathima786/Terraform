
output "name" {
  value = aws_instance.name
}
output "privateIP" {
    value = aws_instance.name.private_ip
  
}
output "publicIP" {
    value = aws_instance.name.public_ip
  
}