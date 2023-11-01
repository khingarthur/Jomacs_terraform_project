# Create an ec2 instance into the private subnet
resource "aws_instance" "main" {
  ami                         = data.aws_ami.latest_ubuntu_image.id
  instance_type               = var.type
  subnet_id                   = aws_subnet.private_sn.id
  security_groups             = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = var.bool_2
  key_name                    = var.keyname
  user_data                   = base64encode(file("script.sh"))


  tags = {
    Name = "${var.tag_prefix} Server"
  }
}
