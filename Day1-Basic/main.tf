resource "aws_vpc" "name1" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Ray-VPC"
    }
}
resource "aws_vpc" "name2" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Ray-VPC-2"
    }
}
resource "aws_subnet" "name1" {
    vpc_id = aws_vpc.name1.id
    cidr_block ="10.0.1.0/24"
    tags ={
        Name ="Subnet-2"
    }
}  
resource "aws_subnet" "name2" {
    vpc_id = aws_vpc.name2.id
    cidr_block ="10.0.1.0/24"
    tags ={
        Name ="Subnet-2"
    }
}  
