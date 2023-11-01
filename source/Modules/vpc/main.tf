# Create a custom vpc
resource "aws_vpc" "main" {
  cidr_block           = var.cidrs["vpc"]
  instance_tenancy     = var.tenancy
  enable_dns_hostnames = var.bool_1
  enable_dns_support   = var.bool_1

  tags = {
    Name = "${var.tag_prefix}"
  }
}

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

# Custom load balancer
resource "aws_lb" "my_lb" {
  name               = "${var.name_prefix}-lb"
  internal           = var.bool_2
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_sn_1.id, aws_subnet.public_sn_2.id, ]
  depends_on         = [aws_internet_gateway.internet_gw]

  tags = {
    Name = "${var.tag_prefix} lb"
  }
}

# Target group for the load balancer, set to port 80
resource "aws_lb_target_group" "my_lb_tg" {
  name     = "${var.name_prefix}-lb-tg"
  port     = var.ports["http"]
  protocol = var.protocols[0]
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "${var.tag_prefix} lb tg"
  }
}


#associate the instance with the target group
resource "aws_lb_target_group_attachment" "project_tg_attachment" {
  target_group_arn = aws_lb_target_group.my_lb_tg.arn
  target_id        = var.ec2_id
  port             = var.ports["http"]
}


# Load balancer listener, listening on port 80
resource "aws_lb_listener" "my_lb_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = var.ports["http"]
  protocol          = var.protocols[0]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_lb_tg.arn
  }

  tags = {
    Name = "${var.tag_prefix} lb listener"
  }
}


# Security Group for Load Balancer
resource "aws_security_group" "lb_sg" {
  name   = "${var.name_prefix}-lb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow http request from anywhere"
    protocol    = var.protocols[2]
    from_port   = var.ports["http"]
    to_port     = var.ports["http"]
    cidr_blocks = ["${var.route}"]
  }

  ingress {
    description = "Allow https request from anywhere"
    protocol    = var.protocols[2]
    from_port   = var.ports["https"]
    to_port     = var.ports["https"]
    cidr_blocks = ["${var.route}"]
  }

  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.protocols[1]
    cidr_blocks = ["${var.route}"]
  }

  tags = {
    Name = "${var.tag_prefix} LB SG"
  }
}

# Security Group For EC2 Instance
resource "aws_security_group" "ec2_sg" {
  name   = "${var.name_prefix}-ec2-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description     = "Allow http request from Load Balancer only"
    from_port       = var.ports["http"]
    to_port         = var.ports["http"]
    protocol        = var.protocols[2]
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    description     = "Allow https request from Load Balancer only"
    from_port       = var.ports["https"]
    to_port         = var.ports["https"]
    protocol        = var.protocols[2]
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    description = "Allow SSH from my IP only"
    from_port   = var.ports["ssh"]
    to_port     = var.ports["ssh"]
    protocol    = var.protocols[2]
    cidr_blocks = ["${var.my_cidre}"]
  }

  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.protocols[1]
    cidr_blocks = ["${var.route}"]
  }

  tags = {
    Name = "${var.tag_prefix} EC2 SG"
  }
}