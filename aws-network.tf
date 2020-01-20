resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  assign_generated_ipv6_cidr_block = false
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  instance_tenancy                 = "default"

  tags = {
    Name             = "${lower(var.company)}-VPC"
    Customer         = "${var.company}"
  }
}

resource "aws_subnet" "aws-subnets-public" {
  count             = length(var.network-public)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.network-public[count.index].subnets-cidr
  availability_zone = var.network-public[count.index].availability_zone

  tags = {
    Name                                        = "public ${var.network-private[count.index].availability_zone}"
    Customer         = "${var.company}"
    Public                                     = 1
  }
}

resource "aws_subnet" "aws-subnets-private" {
  count             = length(var.network-private)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.network-private[count.index].subnets-cidr
  availability_zone = var.network-private[count.index].availability_zone

  tags = {
    Name                                        = "private ${var.network-private[count.index].availability_zone}"
    Customer         = "${var.company}"
    Private                                     = 1
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.company
  }
}

data "aws_subnet_ids" "subnet-ids-private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Private = "1"
  }

  depends_on = [aws_subnet.aws-subnets-public,
    aws_subnet.aws-subnets-private
  ]
}

data "aws_subnet_ids" "subnet-ids-public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Public = "1"
  }

  depends_on = [aws_subnet.aws-subnets-public,
    aws_subnet.aws-subnets-private
  ]
}
