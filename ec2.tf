resource "aws_instance" "cmtr-4ca2aaf4-ec2" {

  ami           = "ami-0fab1b527ffa9b942"
  instance_type = "t2.micro"

  key_name = aws_key_pair.cmtr-4ca2aaf4-keypair.key_name

  vpc_security_group_ids = [var.existing_security_group_id]
  subnet_id              = var.existing_subnet_id

  tags = {
    Name    = "cmtr-4ca2aaf4-ec2"
    Project = "epam-tf-lab"
    ID      = "cmtr-4ca2aaf4"
  }
}
