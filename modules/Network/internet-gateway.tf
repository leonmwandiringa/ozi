
resource "aws_internet_gateway" "network_igw" {
  vpc_id = aws_vpc.network_vpc.id
  tags = merge(
    var.global_tags,
    {
      "Name" = "network Internet Gateway"
    },
  )
  depends_on = [
    aws_vpc.network_vpc,
  ]
}