resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name

  tags = {
    Project = "cmtr-4ca2aaf4"
  }
}
