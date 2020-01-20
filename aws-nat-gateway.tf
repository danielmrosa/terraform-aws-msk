resource "aws_nat_gateway" "nat-gateway" {
  count = length(aws_subnet.aws-subnets-public.*.id)

  allocation_id = element(aws_eip.eip.*.id, count.index)
  subnet_id     = element(aws_subnet.aws-subnets-public.*.id, count.index)

  tags = {
    Name = "NAT Gateway ${count.index}"
  }
}
