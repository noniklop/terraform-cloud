resource "aws_security_group" "ssh_sg" {
  name        = "cmtr-4ca2aaf4-ssh-sg"
  description = "Security Group for SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from allowed_ip_range"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip_range]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cmtr-4ca2aaf4-ssh-sg"
  }
}

resource "aws_security_group" "public_http_sg" {
  name        = "cmtr-4ca2aaf4-public-http-sg"
  description = "Security Group for Public HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP from allowed_ip_range"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip_range]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cmtr-4ca2aaf4-public-http-sg"
  }
}

resource "aws_security_group" "private_http_sg" {
  name        = "cmtr-4ca2aaf4-private-http-sg"
  description = "Security Group for Private HTTP access"
  vpc_id      = var.vpc_id

  ingress {
    description              = "Allow HTTP traffic from Public HTTP Security Group"
    from_port                = 8080
    to_port                  = 8080
    protocol                 = "tcp"
    security_groups = [aws_security_group.public_http_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cmtr-4ca2aaf4-private-http-sg"
  }
}
