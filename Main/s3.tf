# Create custom S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-main-vpc-bucket"

  tags = {
    Name = "${var.tag_prefix} Bucket"
  }
}