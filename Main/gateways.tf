# Internet gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag_prefix} Internet GW"
  }
}

# Elastic IP for NAT gateway 
resource "aws_eip" "nat_gw_eip" {
  depends_on = [aws_internet_gateway.internet_gw]

  tags = {
    Name = "${var.tag_prefix} Nat GW EIP"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_sn_1.id
  depends_on    = [aws_eip.nat_gw_eip]

  tags = {
    Name = "${var.tag_prefix} Nat GW"
  }
}

