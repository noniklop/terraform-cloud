resource "aws_iam_group" "users_group" {
  name = var.iam_group_name
}

data "template_file" "policy" {
  template = file("policy.json")

  vars = {
    bucket_name = "cmtr-4ca2aaf4-bucket-1752066971"
  }
}

resource "aws_iam_policy" "custom_policy" {
  name   = "cmtr-4ca2aaf4-iam-policy"
  policy = data.template_file.policy.rendered

  tags = {
    Project = "cmtr-4ca2aaf4"
  }
}

resource "aws_iam_role" "cmtr_role" {
  name = "cmtr-4ca2aaf4-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = "cmtr-4ca2aaf4"
  }
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  policy_arn = aws_iam_policy.custom_policy.arn
  role       = aws_iam_role.cmtr_role.name
}

resource "aws_iam_instance_profile" "cmtr_profile" {
  name = "cmtr-4ca2aaf4-iam-instance-profile"
  role = aws_iam_role.cmtr_role.name

  tags = {
    Project = "cmtr-4ca2aaf4"
  }
}
