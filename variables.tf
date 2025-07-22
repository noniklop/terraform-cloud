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
