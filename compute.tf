resource "aws_instance" "cmtr-4ca2aaf4-instance" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"

  subnet_id              = data.aws_subnet.cmtr-4ca2aaf4-public-subnet-1.id
  vpc_security_group_ids = [data.aws_security_group.cmtr-4ca2aaf4-sg.id]

  tags = {
    Terraform = "true"
    Project   = "cmtr-4ca2aaf4"
  }
}
