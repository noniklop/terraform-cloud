output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.my_vpc.cidr_block
}

output "public_subnet_ids" {
  value = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]
}

output "public_subnet_cidr_block" {
  value = [aws_subnet.subnet_1.cidr_block, aws_subnet.subnet_2.cidr_block, aws_subnet.subnet_3.cidr_block]
}

output "public_subnet_availability_zone" {
  value = [
    aws_subnet.subnet_1.availability_zone,
    aws_subnet.subnet_2.availability_zone,
    aws_subnet.subnet_3.availability_zone
  ]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_igw.id
}

output "routing_table_id" {
  value = aws_route_table.public.id
}
