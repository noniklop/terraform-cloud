resource "aws_key_pair" "cmtr-4ca2aaf4-keypair" {
  key_name   = "cmtr-4ca2aaf4-keypair"
  public_key = var.ssh_key
}
