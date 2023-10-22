// Create EC2 instances in both VPCs

// EC2 Instance for us-east-1
resource "aws_instance" "use_instance" {
  ami                    = "ami-03eb6185d756497f8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.use_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ping_use.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile_use.name
  provider               = aws.use
}

// EC2 Instance for us-west-2
resource "aws_instance" "usw_instance" {
  ami                    = "ami-0e2e9c570f999a4c8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.usw_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ping_usw.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile_use.name
  provider               = aws.usw

}