variable "ssh_key" {
  type = string
  description = "Provides custom public SSH key"
}

variable "existing_security_group_id" {
  type = string
  description = "SG id"
  default     = "sg-0fb26d06c24bb6abf"
}

variable "existing_subnet_id" {
  type = string
  description = "subnet id"
  default     = "subnet-057febbbaaf302154"
}
