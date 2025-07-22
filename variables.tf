variable "ssh_key_name" {
  description = "The name of the SSH key pair."
  type        = string
  default     = "cmtr-4ca2aaf4-keypair"
}

variable "subnet_id" {
  description = "subnet id"
  type        = list(any)
  default     = ["subnet-01ca054bfb0f898e0", "subnet-0ee5963661542ccdd"]
}
