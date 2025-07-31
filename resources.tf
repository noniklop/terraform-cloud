resource "aws_iam_policy" "name" {
  name        = "cmtr-4ca2aaf4-iam-policy"
  description = "This is an example IAM policy imported by Terraform"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "s3:*"
            ],
            "Resource": "*"
        }
    ]
}

    EOF
}
