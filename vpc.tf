resource "aws_vpc" "my_vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "cmtr-4ca2aaf4-01-subnet-public-a"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "cmtr-4ca2aaf4-01-subnet-public-b"
  }
}

resource "aws_subnet" "subnet_3" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.10.5.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "cmtr-4ca2aaf4-01-subnet-public-с"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "cmtr-4ca2aaf4-01-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "cmtr-4ca2aaf4-01-rt"
  }
}

resource "aws_route_table_association" "subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_3" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.public.id
}
