resource "aws_eip" "eip" {
  count = length(aws_subnet.aws-subnets-public.*.id)
  vpc   = true
   

  depends_on = [data.aws_subnet_ids.subnet-ids-public]
}

resource "aws_eip" "kafka" {
  vpc   = true
  depends_on = [data.aws_subnet_ids.subnet-ids-public]
}

# Elastic IPs association

resource "aws_eip_association" "kafka" {
  instance_id   = "${aws_instance.kafka.id}"
  allocation_id = "${aws_eip.kafka.id}"

  
}