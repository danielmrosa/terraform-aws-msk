resource "aws_instance" "kafka" {
  ami                    = "${var.ami["default"]}"
  instance_type          = "${var.instance_type["kafka"]}"
  key_name               = "${var.ssh_key}"
  subnet_id              = "${aws_subnet.aws-subnets-public.0.id}"
  source_dest_check      = true
  vpc_security_group_ids = ["${aws_security_group.kafka.id}"]

  tags = {
    Name             = "${lower(var.company)}-1a-kafka"
    Customer         = "${var.company}"
  }
}