resource "aws_instance" "web_server" {
  ami           = "ami-0b3e7dd7b2a99b08d"
  instance_type = "t2.micro"

  subnet_id              = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  tags = {
    Terraform = "true"
    Project   = "cmtr-4ca2aaf4"
  }
}
