resource "aws_security_group" "allow_my_ip" {
  name        = "allow_my_ip"
  description = "Security group allowing access only from my IP address"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["x.x.x.x/x"] 
  }
  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_http_connection" {
  name        = "allow_on_port_80"
  description = "Security group allowing access only from my IP address"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_https_connection" {
  name        = "allow_on_port_443"
  description = "Security group allowing access only from my IP address"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ecs_ami.id
  instance_type = "t2.micro"
  iam_instance_profile = "ec2_s3_access_profile"

  tags = {
    Name = "dzieje-sie-backend-deploy-ec2"
  }
  security_groups = [aws_security_group.allow_my_ip.name, aws_security_group.allow_http_connection.name, aws_security_group.allow_https_connection.name]
}

