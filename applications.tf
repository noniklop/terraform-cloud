resource "aws_launch_template" "cmtr_4ca2aaf4_template" {
  name = "cmtr-4ca2aaf4-template"

  instance_type = "t3.micro"

  key_name = var.ssh_key_name

  image_id = "ami-0ca351c241d836d3b"

  iam_instance_profile {
    name = "cmtr-4ca2aaf4-instance_profile"
  }

  network_interfaces {
    security_groups       = ["sg-01002f52cab6d56b0", "sg-0c8d0b9a38f287ec3"]
    delete_on_termination = true
  }



  user_data = base64encode(<<EOT
#!/bin/bash
yum update -y
yum install -y aws-cli httpd jq
systemctl enable httpd
systemctl start httpd

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

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

systemctl restart httpd
EOT
  )
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
  default     = "sg-06c907ec7736a4835" # Задайте ім'я SG для ALB


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
  vpc_id      = "vpc-039c8a3a30d4afdd9"

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
