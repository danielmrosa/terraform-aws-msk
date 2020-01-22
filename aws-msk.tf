resource "aws_msk_cluster" "kafka" {
  cluster_name           = "kafka"
  kafka_version          = "2.3.1"
  number_of_broker_nodes = 2
  enhanced_monitoring = "PER_TOPIC_PER_BROKER"

  broker_node_group_info {
    instance_type  = "kafka.m5.large"
    ebs_volume_size = "100"
    client_subnets = [
      "${aws_subnet.aws-subnets-public.0.id}",
      "${aws_subnet.aws-subnets-public.2.id}"
    ]
    security_groups = [ "${aws_security_group.aws-msk.id}" ]
  }

  encryption_info {
    encryption_in_transit {
        client_broker = "TLS_PLAINTEXT"
        in_cluster    = true
    }
  }
  
  tags = {
    Customer = "Zup"
  }
}

resource "aws_msk_configuration" "kafka" {
  name = "kafka-cfg-22-01"
  kafka_versions = ["2.3.1"]
  server_properties = <<PROPERTIES
auto.create.topics.enable = false
delete.topic.enable = true
PROPERTIES
}