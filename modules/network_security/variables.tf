variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_id" {
  description = "ID of the VPC where the security groups will be deployed"
  type        = string
}

variable "allowed_ip_range" {
  description = "CIDR block or range of IPs allowed to access the security groups"
  type        = string
  default     = "10.10.0.0/16"
}
