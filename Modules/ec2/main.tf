
# EC2 Instance Runnning an Nginx Server 
resource "aws_instance" "main" {
  ami                         = data.aws_ami.latest_ubuntu_image.id
  instance_type               = var.type
  subnet_id                   = var.ec2_subnet_id
  security_groups             = [var.instance_sg]
  associate_public_ip_address = var.bool_2
  key_name                    = "${var.keyname}"
  user_data                   = base64encode(file("script.sh"))

  tags = {
    Name = "${var.ec2_name}"
  }
}

