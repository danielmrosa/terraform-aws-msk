resource "aws_security_group" "aws-msk" {
  name   = "msk"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 9092
    to_port         = 9094
    protocol        = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    description     = "Kafka"
  }
  ingress {
    from_port       = 11001
    to_port         = 11002
    protocol        = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    description     = "Monitoring"
  }
   ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    description     = "Zookeeper"
  }

   ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["${local.workstation-external-cidr}"]
    description     = "SSH"
  }
   egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  } 
  tags = {
    Name = "Msk"
  }
}

resource "aws_security_group" "kafka" {
  name   = "kafka"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 9092
    to_port         = 9094
    protocol        = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    description     = "Kafka"
  }
   ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    description     = "Zookeeper"
  }

   ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["${local.workstation-external-cidr}"]
    description     = "SSH"
  } 
   ingress {
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    description     = "GrafanaDatasource"
  }
   ingress {
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    cidr_blocks = ["${local.workstation-external-cidr}"]
    description     = "Prometheus"
  } 
   ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    cidr_blocks = ["${local.workstation-external-cidr}"]
    description     = "Grafana"
  }
   egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Kafka"
  }
}