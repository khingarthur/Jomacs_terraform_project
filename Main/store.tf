# SSM Parameters for critical values
resource "aws_ssm_parameter" "lb_dns" {
  name        = "${var.ssm_prifix}/load-balancer/dns"
  type        = "String"
  value       = aws_lb.my_lb.dns_name
  description = "ssm parameter to store load balancer dns"
}

resource "aws_ssm_parameter" "ami_id" {
  name        = "${var.ssm_prifix}/ami/id"
  type        = "String"
  value       = data.aws_ami.latest_ubuntu_image.id
  description = "ssm parameter to store ami id of the latest ubuntu image"
}

resource "aws_ssm_parameter" "vpc_id" {
  name        = "${var.ssm_prifix}/id"
  type        = "String"
  value       = aws_vpc.main.id
  description = "ssm parameter for vpc id"
}


resource "aws_ssm_parameter" "subnets_ids" {
  name        = "${var.ssm_prifix}/public-sn/ids"
  type        = "String"
  value       = join(",", [aws_subnet.private_sn.id, aws_subnet.public_sn_1.id, aws_subnet.public_sn_2.id])
  description = "ssm parameter to store subnet ids in public and private subnets"
}

resource "aws_ssm_parameter" "ec2_private_ip" {
  name        = "${var.ssm_prifix}/ec2/private-ip"
  type        = "String"
  value       = aws_instance.main.private_ip
  description = "ssm parameter to store ec2 instance private ip address"
}


resource "aws_ssm_parameter" "gateway_ids" {
  name        = "${var.ssm_prifix}/gateway/ids"
  type        = "String"
  value       = join(",", [aws_internet_gateway.internet_gw.id, aws_nat_gateway.nat_gw.id])
  description = "ssm parameter to store gateway ids"
}


resource "aws_ssm_parameter" "rt_ids" {
  name        = "${var.ssm_prifix}/rt/ids"
  type        = "String"
  value       = join(",", [aws_route_table.public_rt.id, aws_route_table.private_rt.id])
  description = "ssm parameter store route table ids"
}

resource "aws_ssm_parameter" "sg_ids" {
  name        = "${var.ssm_prifix}/sg/ids"
  type        = "String"
  value       = join(",", [aws_security_group.lb_sg.id, aws_security_group.ec2_sg.id])
  description = "ssm parameter to store security group ids"
}

resource "aws_ssm_parameter" "lb_tg" {
  name        = "${var.ssm_prifix}/lb/target_groups"
  type        = "String"
  value       = aws_lb_target_group.my_lb_tg.arn
  description = "ssm parameter for load balancer target groups arn"
}