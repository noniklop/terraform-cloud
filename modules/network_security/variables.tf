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
  type        = list(string)
  default     = ["18.153.146.156/32", "188.163.9.79/32"]
}
