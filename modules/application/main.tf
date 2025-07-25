resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "example" {
  key_name   = "my-key-pair" # Назва ключа
  public_key = tls_private_key.example.public_key_openssh
}

data "aws_ami" "amazon_linux_2023" {
  owners      = ["amazon"] # AMI власність компанії AWS
  most_recent = true       # Отримуємо найостаннішу версію AMI

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"] # Шаблон назви для Amazon Linux 2023
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] # Вказано архітектуру
  }
}

resource "aws_launch_template" "compute_template" {
  name = "cmtr-4ca2aaf4-template"

  instance_type = var.instance_type

  key_name = "my-key-pair" # Змініть на вашу AWS ключову назву

  image_id = data.aws_ami.amazon_linux_2023.id

  network_interfaces {
    security_groups       = [var.ssh_sg, var.public_http_sg]
    delete_on_termination = true
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {}))

  tags = {
    Name = "cmtr-4ca2aaf4-template"
  }
}

# *********** APPLICATION LOAD BALANCER ***********

# Create Load Balancer
resource "aws_lb" "app_lb" {
  name               = "cmtr-4ca2aaf4-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.private_http_sg]
  subnets = [
    var.subnet_a_id,
    var.subnet_b_id,
    var.subnet_c_id
  ]

  tags = {
    Name = "cmtr-4ca2aaf4-lb"
  }
}

# Create Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "cmtr-4ca2aaf4-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {
    Name = "cmtr-4ca2aaf4-tg"
  }
}

# Create Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# *********** AUTO SCALING GROUP ***********

resource "aws_autoscaling_group" "asg" {
  name                = "cmtr-4ca2aaf4-asg"
  max_size            = 2
  min_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = [var.subnet_a_id, var.subnet_b_id, var.subnet_c_id]
  launch_template {
    id      = aws_launch_template.compute_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  lifecycle {
    ignore_changes = [
      target_group_arns,
      load_balancers
    ]
  }
}

# Attach Auto Scaling Group to Load Balancer
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = aws_lb_target_group.app_tg.arn
}
