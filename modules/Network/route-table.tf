resource "aws_route_table" "network_public_rt" {
  vpc_id = aws_vpc.network_vpc.id
  tags = merge(
    var.global_tags,
    {
      "Name" = "network_public_rt"
    },
  )
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.network_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.network_igw.id
}