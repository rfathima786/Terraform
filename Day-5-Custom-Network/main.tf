resource "aws_instance" "name" {
    ami ="ami-07860a2d7eb515d9a"
}
  resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Ray-VPC"
    }
}

resource "aws_eip" "name" {

    vpc = true

  
}


resource aws_subnet "name"{
    vpc_id =aws_vpc.name.id
    cidr_block ="10.0.0.0/24"
}
resource "aws_nat_gateway" "name" {
    allocation_id =aws_eip.name.id
    subnet_id =aws_subnet.name.id
  
}
resource aws_route_table "name"
{
    vpc_id =aws_vpc.name.id
    
}