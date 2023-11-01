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
  target_id        = aws_instance.main.id
  port             = var.ports["http"]
}


# Load balancer listener, listening on port 80
resource "aws_lb_listener" "my_lb_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = var.ports["http"]
  protocol          = var.protocols[0]

  default_action {
    type             = var.action
    target_group_arn = aws_lb_target_group.my_lb_tg.arn
  }

  tags = {
    Name = "${var.tag_prefix} lb listener"
  }
}
