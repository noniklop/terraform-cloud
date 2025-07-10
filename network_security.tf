resource "aws_security_group" "empty_sg" {
  name   = "empty-1488"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 1488
    to_port     = 1488
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }
}

resource "aws_security_group" "ssh_sg" {
  name   = "cmtr-4ca2aaf4-ssh-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }
}

resource "aws_security_group" "public_sg" {
  name   = "cmtr-4ca2aaf4-public-http-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }
}

resource "aws_security_group" "private_sg" {
  name   = "cmtr-4ca2aaf4-private-http-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.public_sg.id]
  }
}

resource "aws_security_group_rule" "what" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["10.1.1.0/24"]
  security_group_id = aws_security_group.empty_sg.id
}

resource "aws_network_interface_sg_attachment" "public_instance_ssh" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = "eni-011e42be3e11a598c"
}

resource "aws_network_interface_sg_attachment" "public_instance_http" {
  security_group_id    = aws_security_group.public_sg.id
  network_interface_id = "eni-011e42be3e11a598c"
}

resource "aws_network_interface_sg_attachment" "private_instance_ssh" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = "eni-0d97fbb022ff720df"
}

resource "aws_network_interface_sg_attachment" "private_instance_http" {
  security_group_id    = aws_security_group.private_sg.id
  network_interface_id = "eni-0d97fbb022ff720df"
}
