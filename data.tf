data "aws_vpc" "cmtr-4ca2aaf4-vpc" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-4ca2aaf4-vpc"]
  }
}

data "aws_subnet" "cmtr-4ca2aaf4-public-subnet-1" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-4ca2aaf4-public-subnet-1"]
  }
}

data "aws_security_group" "cmtr-4ca2aaf4-sg" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-4ca2aaf4-sg"]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
