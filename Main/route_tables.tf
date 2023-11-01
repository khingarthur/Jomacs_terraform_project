# Route table for Private Subnet - connecting to Nat Gateway  
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = var.route
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.tag_prefix} Pri RT"
  }
}

# Associate the route table with Private Subnet
resource "aws_route_table_association" "nat" {
  subnet_id      = aws_subnet.private_sn.id
  route_table_id = aws_route_table.private_rt.id
}

# Route table for Public Subnets - Connecting to the Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "${var.tag_prefix} Pub RT"
  }
}

# Associate the route table with Public Subnet 1
resource "aws_route_table_association" "internet_1" {
  subnet_id      = aws_subnet.public_sn_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate the route table with Public Subnet 2
resource "aws_route_table_association" "internet_2" {
  subnet_id      = aws_subnet.public_sn_2.id
  route_table_id = aws_route_table.public_rt.id
}
