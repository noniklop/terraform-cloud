variable "ssh_key_name" {
  description = "The name of the SSH key pair."
  type        = string
  default     = "cmtr-4ca2aaf4-keypair"
}

variable "subnet_id" {
  description = "subnet id"
  type        = list(any)
  default     = ["subnet-0074fe3ff8892d82b", "subnet-046c487cec2077762"]
}
