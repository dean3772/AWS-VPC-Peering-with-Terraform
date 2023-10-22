// Create a VPC in us-east-1
// VPC and Subnet for us-east-1
resource "aws_vpc" "use_vpc" {
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"
  provider             = aws.use
    tags = {
    Name = "use_vpctfssm"
  }
}
// Create a subnet in the VPC
resource "aws_subnet" "use_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.use_vpc.id
  availability_zone = "us-east-1a"

  provider   = aws.use
      tags = {
    Name = "use_subnettfssm"
  }
}
// Create a VPC in us-west-2
// VPC and Subnet for us-west-2
resource "aws_vpc" "usw_vpc" {
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = "10.1.0.0/16"
  provider             = aws.usw
      tags = {
    Name = "usw_vpctfssm"
  }
}
// Create a subnet in the VPC
resource "aws_subnet" "usw_subnet" {
  cidr_block = "10.1.1.0/24"
  vpc_id     = aws_vpc.usw_vpc.id
  availability_zone = "us-west-2a"
  provider   = aws.usw
        tags = {
    Name = "usw_subnettfssm"
  }
}

output "selected_use_vpc" {
  value = aws_vpc.use_vpc.id
}

output "selected_usw_vpc" {
  value = aws_vpc.usw_vpc.id
}
// Create VPC Peering between us-east-1 and us-west-2 VPCs

resource "aws_vpc_peering_connection" "use_usw_peering" {
  peer_vpc_id = aws_vpc.usw_vpc.id
  vpc_id      = aws_vpc.use_vpc.id
  provider    = aws.use
  peer_owner_id = "827232305028"
  peer_region = "us-west-2"
}

// Accept the VPC Peering on the us-west-2 side
# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.usw
  vpc_peering_connection_id = aws_vpc_peering_connection.use_usw_peering.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

// Create VPC Endpoints for SSM in both regions
// VPC Endpoints for SSM in us-east-1
resource "aws_vpc_endpoint" "ssm_endpoint_use" {
  provider = aws.use
  vpc_id   = aws_vpc.use_vpc.id
  service_name = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.allow_ping_use.id]
  subnet_ids = [aws_subnet.use_subnet.id] 
  private_dns_enabled = true

}

resource "aws_vpc_endpoint" "ssm_messaging_endpoint_use" {
  provider = aws.use
  vpc_id   = aws_vpc.use_vpc.id
  service_name = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.allow_ping_use.id]
  subnet_ids = [aws_subnet.use_subnet.id] 
  private_dns_enabled = true

}

resource "aws_vpc_endpoint" "ec2_messaging_endpoint_use" {
  provider = aws.use
  vpc_id   = aws_vpc.use_vpc.id
  service_name = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.allow_ping_use.id]
  subnet_ids = [aws_subnet.use_subnet.id] 
  private_dns_enabled = true

}

// VPC Endpoints for SSM in us-west-2
resource "aws_vpc_endpoint" "ssm_endpoint_usw" {
  provider = aws.usw
  vpc_id   = aws_vpc.usw_vpc.id
  service_name = "com.amazonaws.us-west-2.ssm"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.allow_ping_usw.id]
  subnet_ids = [aws_subnet.usw_subnet.id]
  private_dns_enabled = true

}

resource "aws_vpc_endpoint" "ssm_messaging_endpoint_usw" {
  provider = aws.usw
  vpc_id   = aws_vpc.usw_vpc.id
  service_name = "com.amazonaws.us-west-2.ssmmessages"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.allow_ping_usw.id]
  subnet_ids = [aws_subnet.usw_subnet.id]
  private_dns_enabled = true


}

resource "aws_vpc_endpoint" "ec2_messaging_endpoint_usw" {
  provider = aws.usw
  vpc_id   = aws_vpc.usw_vpc.id
  service_name = "com.amazonaws.us-west-2.ec2messages"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.allow_ping_usw.id]
  subnet_ids = [aws_subnet.usw_subnet.id]
  private_dns_enabled = true
}

// Add route in us-east-1 VPC to us-west-2
resource "aws_route" "route_use_to_usw" {
  provider                  = aws.use
  route_table_id            = aws_vpc.use_vpc.main_route_table_id 
  destination_cidr_block    = aws_vpc.usw_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.use_usw_peering.id
}

// Add route in us-west-2 VPC to us-east-1
resource "aws_route" "route_usw_to_use" {
  provider                  = aws.usw
  route_table_id            = aws_vpc.usw_vpc.main_route_table_id  
  destination_cidr_block    = aws_vpc.use_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.use_usw_peering.id
}
