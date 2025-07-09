variable "iam_group_name" {
  description = "group name"
  type        = string
  default     = "cmtr-4ca2aaf4-iam-group"
}

variable "policy_name" {
  description = "policy name"
  type        = string
  default     = "cmtr-4ca2aaf4-iam-policy"
}

variable "role_name" {
  description = "role name"
  type        = string
  default     = "cmtr-4ca2aaf4-iam-role"
}

variable "instance_profile" {
  description = "instance profile"
  type        = string
  default     = "cmtr-4ca2aaf4-iam-instance-profile"
}
