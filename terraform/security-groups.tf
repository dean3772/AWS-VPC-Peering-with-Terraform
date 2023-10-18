resource "aws_security_group" "allow_ping" {
  count = 2
  provider = count.index == 0 ? aws.east : aws.west

  name        = "allow_ping"
  description = "Allow ICMP traffic"

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}