# Key Pair for ssh
resource "aws_key_pair" "my_key" {
  key_name   = var.keyname
  public_key = file("${var.keypath}")

  tags = {
    Name = "${var.tag_prefix}-Keypair"
  }

}