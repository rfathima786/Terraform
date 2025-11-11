resource "aws_instance" "Ray-Test" {
    ami = data.aws_ami.test.id
    instance_type =t2.micro
  
}

data "aws_ami" "test" {
    most_recent =true
    owners = ["amazon"]
    filter {
        name = "name"
        values =["frontend-ami-*|"]     

    }
  
}