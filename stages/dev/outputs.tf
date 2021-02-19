output "aws_vpc" {
  value = module.network.aws_vpc
}

output "aws_internet_gateway" {
  value = module.network.aws_internet_gateway
}

output "aws_security_group" {
  value = module.network.aws_security_group
}

output "aws_public_subnet" {
  value = module.network.aws_public_subnet
}

output "aws_public_subnets" {
  value = module.network.aws_public_subnets
}