variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "ssh_sg" {
  description = "ssh sg id"
  type        = string
}

variable "public_http_sg" {
  description = "http sg id"
  type        = string
}

variable "private_http_sg" {
  description = "private http sg id"
  type        = string
}

variable "subnet_a_id" {
  description = "subnet a id"
  type        = string
}

variable "subnet_b_id" {
  description = "subnet b id"
  type        = string
}

variable "subnet_c_id" {
  description = "subnet c id"
  type        = string
}
