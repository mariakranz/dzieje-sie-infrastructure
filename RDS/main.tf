#create a security group for RDS Database Instance
resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "manged_by" = "terraform"
    "project" = "dzieje-sie"
  }
}

#create a RDS Database Instance
resource "aws_db_instance" "myinstance" {
  engine               = "mysql"
  identifier           = "ds-database"
  allocated_storage    =  20
  engine_version       = "8.0.36"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot  = true
  publicly_accessible =  true
  enabled_cloudwatch_logs_exports = ["error"]
  deletion_protection = "true"
  allow_major_version_upgrade = true
  apply_immediately = true
  tags = {
    "manged_by" = "terraform"
    "project" = "dzieje-sie"
  }
}