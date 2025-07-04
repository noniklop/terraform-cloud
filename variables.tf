variable "vpc_name" {
  type        = string
  description = "Name of VPC"
  default     = "cmtr-4ca2aaf4-01-vpc"
}

variable "subnet1_name" {
  type        = string
  description = "Name of subnet1"
  default     = "cmtr-4ca2aaf4-01-subnet-public-a"
}

variable "subnet2_name" {
  type        = string
  description = "Name of subnet2"
  default     = "cmtr-4ca2aaf4-01-subnet-public-b"
}

variable "subnet3_name" {
  type        = string
  description = "Name of subnet3"
  default     = "cmtr-4ca2aaf4-01-subnet-public-c"
}

variable "subnet1_az" {
  type        = string
  description = "AZ subnet1"
  default     = "eu-west-1a"
}

variable "subnet2_az" {
  type        = string
  description = "AZ subnet2"
  default     = "eu-west-1b"
}

variable "subnet3_az" {
  type        = string
  description = "AZ subnet3"
  default     = "eu-west-1c"
}

variable "igw_name" {
  type        = string
  description = "name of internet gateway"
  default     = "cmtr-4ca2aaf4-01-igw"
}

variable "route_table_name" {
  type        = string
  description = "Route table name"
  default     = "cmtr-4ca2aaf4-01-rt"
}
