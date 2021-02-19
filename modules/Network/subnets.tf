#network
#Techadon Group

resource "aws_subnet" "network_public_subnet" {
  count             = var.az_count
  vpc_id            = aws_vpc.network_vpc.id
  cidr_block        = "${var.vpc_cidr_base}${var.public_subnet_cidrs[format("zone%d", count.index)]}"
  availability_zone = element(split(", ", var.aws_azs), count.index)
  map_public_ip_on_launch = true
  tags = merge(
    var.global_tags,
    {
      "Name" = "network_public_subnet_az${count.index + 1}"
    },
  )
  depends_on = [
    aws_vpc.network_vpc,
  ]
}

resource "aws_route_table_association" "ibl_public_assoc" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.network_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.network_public_rt.id
}