resource "aws_db_instance" "ray" {
  allocated_storage       = 10
  db_name                 = "mydb"
  identifier              = "rds-ray-test"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Cloud123"
  db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
  parameter_group_name    = "default.mysql8.0"
 

  # Enable backups and retention
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable monitoring (CloudWatch Enhanced Monitoring)
  monitoring_interval      = 60  # Collect metrics every 60 seconds
  monitoring_role_arn      = aws_iam_role.rds_role_monitor.arn

  # Enable performance insights
  # performance_insights_enabled          = true
  # performance_insights_retention_period = 7  # Retain insights for 7 days

  # Maintenance window
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = true

  # Skip final snapshot
  skip_final_snapshot = true
}

resource "aws_db_instance" "replica" {
  identifier             = "my-db-replica"
  replicate_source_db    = aws_db_instance.ray.arn
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





# # IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_role_monitor" {
  name = "rds_role_monitor"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

#IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_role_monitor.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


resource "aws_db_subnet_group" "sub-grp" {
name       = "rds-sg-again"
subnet_ids = ["subnet-0c3ee70e2199ac9b0", "subnet-032c1cce4b023df2f"]

tags = {
Name = "My DB subnet group"
}
}




####### with data source ###########
/* data "aws_subnet" "subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["subnet-1"]
  }
} */