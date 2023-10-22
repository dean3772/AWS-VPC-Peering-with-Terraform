// Define Security Group in us-east-1 to allow ICMP and HTTPS
// Security Group for us-east-1 allowing ICMP (ping)
resource "aws_security_group" "allow_ping_use" {
  name        = "allow_ping_use"
  description = "Allow ICMP"
  vpc_id      = aws_vpc.use_vpc.id
  provider    = aws.use

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.usw_vpc.cidr_block]
  }

    egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.usw_vpc.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
// Define Security Group in us-west-2 to allow ICMP and HTTPS
// Security Group for us-west-2 allowing ICMP (ping)
resource "aws_security_group" "allow_ping_usw" {
  name        = "allow_ping_usw"
  description = "Allow ICMP"
  vpc_id      = aws_vpc.usw_vpc.id
  provider    = aws.usw

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.use_vpc.cidr_block]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.use_vpc.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}