
output "aws_vpc" {
  value = aws_vpc.network_vpc.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.network_igw.id
}

output "aws_security_group" {
  value = aws_security_group.network_default_sg.id
}

output "aws_public_subnet" {
  value = aws_subnet.network_public_subnet[0].id
}

output "aws_public_subnets" {
  value = aws_subnet.network_public_subnet.*.id
}