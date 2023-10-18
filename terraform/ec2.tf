resource "aws_instance" "company_instance" {
  count = 2
  provider = count.index == 0 ? aws.east : aws.west

  ami           = "ami-0c55b159cbfafe1f0" # Update this with the latest AMI
  instance_type = "t2.micro"

  security_groups = [aws_security_group.allow_ping[count.index].name]

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  tags = {
    Name = "company-${count.index + 1}"
  }
}
