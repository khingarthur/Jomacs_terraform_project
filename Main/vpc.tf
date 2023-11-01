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
