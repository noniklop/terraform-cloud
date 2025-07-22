resource "aws_launch_template" "cmtr_4ca2aaf4_template" {
  name = "cmtr-4ca2aaf4-template"

  instance_type = "t3.micro"

  key_name = var.ssh_key_name

  iam_instance_profile {
    name = "cmtr-4ca2aaf4-instance_profile"
  }

  network_interfaces {
    delete_on_termination = true
  }

  security_group_names = [
    "cmtr-4ca2aaf4-ec2_sg",
    "cmtr-4ca2aaf4-http_sg"
  ]

  user_data = <<-EOT
#!/bin/bash

# === Update system packages ===
yum update -y

# === Install necessary utilities ===
yum install -y aws-cli httpd jq

# === Enable and start web server (httpd) ===
systemctl enable httpd
systemctl start httpd

# === Retrieve instance metadata using IMDSv2 ===
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

# === Create HTML file with instance information ===
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
</head>
<body>
    <h1>Welcome to your web server!</h1>
    <p>This message was generated on instance <b>$INSTANCE_ID</b> with the following IP: <b>$PRIVATE_IP</b></p>
</body>
</html>
EOF

# === Restart the httpd service to load the new index.html ===
systemctl restart httpd
EOT

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Terraform = "true"
    Project   = "cmtr-4ca2aaf4"
  }
}

resource "aws_autoscaling_group" "cmtr_4ca2aaf4_asg" {
  name             = "cmtr-4ca2aaf4-asg"
  desired_capacity = 2
  min_size         = 1
  max_size         = 2

  launch_template {
    id      = aws_launch_template.cmtr_4ca2aaf4_template.id
    version = "$Latest" // Використовує останню версію шаблону
  }

  // Ігнорування змін параметрів load_balancers і target_group_arns
  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }

  vpc_zone_identifier = var.subnet_id // Потрібно вказати список підмереж для ASG

}

variable "alb_sg" {
  description = "Security group for ALB"
  default     = "cmtr-4ca2aaf4-sglb" # Задайте ім'я SG для ALB


}

# Application Load Balancer
resource "aws_lb" "cmtr_4ca2aaf4_loadbalancer" {
  name               = "cmtr-4ca2aaf4-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  subnets            = var.subnet_id

  enable_deletion_protection = false

  tags = {
    Terraform = "true"
    Project   = "cmtr-4ca2aaf4"
  }
}

# Listener Configuration for ALB (HTTP on port 80)
resource "aws_lb_listener" "cmtr_4ca2aaf4_listener" {
  load_balancer_arn = aws_lb.cmtr_4ca2aaf4_loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cmtr_4ca2aaf4_tg.arn
  }

  tags = {
    Terraform = "true"
    Project   = "cmtr-4ca2aaf4"
  }
}

# Target Group for Auto Scaling Group
resource "aws_lb_target_group" "cmtr_4ca2aaf4_tg" {
  name        = "cmtr-4ca2aaf4-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-04ef3e68171093c48"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Terraform = "true"
    Project   = "cmtr-4ca2aaf4"
  }
}

# Attach Auto Scaling Group to Target Group
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.cmtr_4ca2aaf4_asg.name
  lb_target_group_arn    = aws_lb_target_group.cmtr_4ca2aaf4_tg.arn
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair."
  type        = string
  default     = "key_name"
}

variable "subnet_id" {
  description = "subnet id"
  type        = list(any)
  default     = ["subnet-08f0a39437cd018f0", "subnet-0907970833ae5a87c", "subnet-024f7fd99f6bb7696", "subnet-0cf879f3aa5a08c4e"]
}
