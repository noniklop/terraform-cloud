terraform {
  backend "s3" {
    bucket = "cmtr-4ca2aaf4-backend-new-bucket-1753782556"
    key    = "tf_code.tfstate"
    region = "us-east-1"
  }
}
