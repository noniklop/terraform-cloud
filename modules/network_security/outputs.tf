output "ssh_security_group_id" {
  description = "ID of the SSH Security Group"
  value       = aws_security_group.ssh_sg.id
}

output "public_http_security_group_id" {
  description = "ID of the Public HTTP Security Group"
  value       = aws_security_group.public_http_sg.id
}

output "private_http_security_group_id" {
  description = "ID of the Private HTTP Security Group"
  value       = aws_security_group.private_http_sg.id
}
