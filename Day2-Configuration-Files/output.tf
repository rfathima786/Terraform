
output "name" {
  value = aws_instance.name
}
output "AZ" {
 value = aws_subnet.public_subnet.availability_zone
}
output "privateIP" {
    value = aws_instance.name.private_ip
  
}
output "publicIP" {
    value = aws_instance.name.public_ip
  
}