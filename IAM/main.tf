resource "aws_iam_user" "ec2_user" {
  name = "Github-Service-Account" 
}

resource "aws_iam_access_key" "ec2_user_access_key" {
  user = aws_iam_user.ec2_user.name
}

resource "aws_iam_user_policy_attachment" "ec2_user_attachment" {
  user       = aws_iam_user.ec2_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess" 
}
    

resource "aws_iam_role" "ec2_role" {
  name               = "ec2_s3_full_access_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "ec2.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "s3_full_access_policy"
  description = "Provides full access to S3 resources"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }]
  })
}

resource "aws_iam_policy" "rds_full_access_policy" {
  name        = "rds_full_access_policy"
  description = "Provides full access to RDS resources"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",  
      "Action": "rds:*",
      "Resource": "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_rds_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.rds_full_access_policy.arn
}

resource "aws_iam_instance_profile" "example_instance_profile" {
  name = "ec2_s3_access_profile"
  role = aws_iam_role.ec2_role.name
}