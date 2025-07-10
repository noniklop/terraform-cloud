variable "allowed_ip_range" {
  description = "list of IP address range for secure access"
  type        = list(string)
  default     = ["188.163.9.79/32", "18.153.146.156/32"]
}
