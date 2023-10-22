// SSM IAM Role and Policies
resource "aws_iam_role" "ssm_role_use" {
  name = "ssm_roletfssm"
  provider = aws.use

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ssm_profile_use" {
  provider = aws.use
  name = "ssm_profiletfssm"
  role = aws_iam_role.ssm_role_use.name
}

resource "aws_iam_role_policy_attachment" "ssm_attach_use" {
  provider = aws.use
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_role_use.name
}

