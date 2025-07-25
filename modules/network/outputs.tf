output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.cmtr_vpc.id
}

output "subnet_a_id" {
  description = "subnet a id"
  value = aws_subnet.public_subnet_a.id
}

output "subnet_b_id" {
  description = "subnet b id"
  value = aws_subnet.public_subnet_b.id
}

output "subnet_c_id" {
  description = "subnet c id"
  value = aws_subnet.public_subnet_c.id
}
