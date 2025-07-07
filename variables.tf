variable "ssh_key" {
  description = "Provides custom public SSH key"
}

variable "existing_security_group_id" {
  description = "SG id"
  default     = "sg-0fb26d06c24bb6abf"
}

variable "existing_subnet_id" {
  description = "subnet id"
  default     = "subnet-057febbbaaf302154"
}
