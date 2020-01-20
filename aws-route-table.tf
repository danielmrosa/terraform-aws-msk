resource "aws_route_table" "public" {
  count  = length(aws_subnet.aws-subnets-public.*.id)
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "public subnet"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}

resource "aws_route_table" "private" {
  count  = length(aws_subnet.aws-subnets-private.*.id)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "private subnet"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.aws-subnets-public.*.id)
  subnet_id      = element(aws_subnet.aws-subnets-public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)

  depends_on = [aws_route_table.public]
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.aws-subnets-private.*.id)
  subnet_id      = element(aws_subnet.aws-subnets-private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)

  depends_on = [aws_route_table.private]
}

resource "aws_route" "aws-route-nat-gateway" {
  count                  = length(aws_subnet.aws-subnets-private.*.id)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat-gateway.*.id, count.index)
}
