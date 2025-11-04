
resource "aws_db_instance" "replica-only" {
  identifier             = "my-db-replica"
  replicate_source_db    = aws_db_instance.ray.id
  instance_class         = "db.t3.micro"
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.sub-grp.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  # No need to specify engine, credentials, or allocated_storage (inherited)
}
resource aws_security_group "db_sg" {
  name  ="db_sg"
  vpc_id ="vpc-008ed6a5884e87609"
  ingress {
    from_port =3306
    to_port =3306
    protocol ="tcp"
    cidr_blocks = ["10.0.0.0/16"] 
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_subnet_group" "sub-grp" {
name       = "rds-sg-again"
subnet_ids = ["subnet-0c3ee70e2199ac9b0", "subnet-032c1cce4b023df2f"]

tags = {
Name = "My DB subnet group"
}
}