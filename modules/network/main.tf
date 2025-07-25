resource "aws_vpc" "cmtr_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "cmtr-4ca2aaf4-vpc"
  }
}

# Створення публічної підмережі в AZ eu-west-1a
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.cmtr_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "eu-west-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "cmtr-4ca2aaf4-subnet-public-a"
  }
}

# Створення публічної підмережі в AZ eu-west-1b
resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.cmtr_vpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "eu-west-1b"

  map_public_ip_on_launch = true

  tags = {
    Name = "cmtr-4ca2aaf4-subnet-public-b"
  }
}

# Створення публічної підмережі в AZ eu-west-1c
resource "aws_subnet" "public_subnet_c" {
  vpc_id            = aws_vpc.cmtr_vpc.id
  cidr_block        = "10.10.5.0/24"
  availability_zone = "eu-west-1c"

  map_public_ip_on_launch = true

  tags = {
    Name = "cmtr-4ca2aaf4-subnet-public-c"
  }
}

# Створення Internet Gateway
resource "aws_internet_gateway" "cmtr_igw" {
  vpc_id = aws_vpc.cmtr_vpc.id

  tags = {
    Name = "cmtr-4ca2aaf4-igw"
  }
}

# Створення таблиці маршрутизації
resource "aws_route_table" "cmtr_rt" {
  vpc_id = aws_vpc.cmtr_vpc.id

  tags = {
    Name = "cmtr-4ca2aaf4-rt"
  }
}

# Додавання маршруту до Internet Gateway в таблиці маршрутизації
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.cmtr_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cmtr_igw.id
}

# Асоціація таблиці маршрутизації з публічними підмережами
resource "aws_route_table_association" "public_subnet_a_rt" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.cmtr_rt.id
}

resource "aws_route_table_association" "public_subnet_b_rt" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.cmtr_rt.id
}

resource "aws_route_table_association" "public_subnet_c_rt" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.cmtr_rt.id
}
