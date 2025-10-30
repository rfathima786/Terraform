resource "aws_instance" "name" {
    instance_type = var.instance_type
    ami = var.ami
    region = var.region   
        
}  

resource "aws_vpc" "ray_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "ray-vpc-2" }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.ray_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = { Name = "ray-public-subnet" }
}
resource "aws_internet_gateway" "ray_igw" {
  vpc_id = aws_vpc.ray_vpc.id
  tags = { Name = "ray-igw" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ray_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ray_igw.id
  }
  tags = { Name = "ray-public-rt" }
}
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


