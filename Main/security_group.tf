
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