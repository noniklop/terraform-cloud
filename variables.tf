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

variable "state_bucket" {
  description = "state bucket"
  type        = string
  default     = "cmtr-4ca2aaf4-tf-state-1753102282"
}

variable "state_key" {
  description = "state bucket"
  type        = string
  default     = "infra.tfstate"
}
