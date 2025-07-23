variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "eu-west-1"
}

variable "project_id" {
  description = "project id"
  type        = string
  default     = "cmtr-4ca2aaf4"
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = "cmtr-4ca2aaf4-vpc"
}

variable "public_subnet_name" {
  description = "public subnet name"
  type        = string
  default     = "cmtr-4ca2aaf4-public-subnet-1"
}

variable "security_group_name" {
  description = "security group name"
  type        = string
  default     = "cmtr-4ca2aaf4-sg"
}
