data "aws_ami" "ecs_ami" {
    owners           = ["self"]
    filter {
    name   = "name"
    values = ["backup-image-from-ec2"]
  }
  
}