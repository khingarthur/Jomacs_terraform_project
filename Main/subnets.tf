# Creating a Private subnet
resource "aws_subnet" "private_sn" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidrs["sn1"]
  map_public_ip_on_launch = var.bool_2
  availability_zone       = var.azs[0]

  tags = {
    Name = "${var.tag_prefix} ${var.sn1_nam}"
  }
}

# Creating Public subnet 1
resource "aws_subnet" "public_sn_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidrs["sn2"]
  map_public_ip_on_launch = var.bool_1
  availability_zone       = var.azs[0]

  tags = {
    Name = "${var.tag_prefix} ${var.sn2_nam[0]}"
  }
}

# Creating  Public Subnet 2
resource "aws_subnet" "public_sn_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidrs["sn3"]
  map_public_ip_on_launch = var.bool_1
  availability_zone       = var.azs[1]

  tags = {
    Name = "${var.tag_prefix} ${var.sn2_nam[1]}"
  }
}

