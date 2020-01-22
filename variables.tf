variable "region" {
  type    = "string"
  default = "us-west-2"
}

variable "vpc-cidr" {
  type    = "string"
  default = "10.11.0.0/16"
}


variable "zup_network_public" {
    default = "186.248.164.114/32"
}

variable  "ami" {
    type    = "map"
    default = {
        default    = "ami-0931e7420c912892b"
    }
}

variable  "instance_type" {
    type    = "map"
    default = {
        kafka  = "t2.small"
  }
}

variable "ssh_key" {
    default = "provisioning-zupshare-key"
}

variable "kafka_count" {
    default = 1
}

variable "company" {
    default = "ZupShare"
}


variable "network-private" {
  type = list(object({
    subnets-cidr      = string
    availability_zone = string
    access-layer      = string
  }))

  default = [
    { subnets-cidr : "10.11.0.0/21", availability_zone : "us-west-2a", access-layer : "private" },
    { subnets-cidr : "10.11.8.0/21", availability_zone : "us-west-2b", access-layer : "private" },
    { subnets-cidr : "10.11.16.0/21", availability_zone : "us-west-2c", access-layer : "private" },
  ]
}

variable "network-public" {
  type = list(object({
    subnets-cidr      = string
    availability_zone = string
    access-layer      = string
  }))

  default = [
    { subnets-cidr : "10.11.24.0/21", availability_zone : "us-west-2a", access-layer : "public" },
    { subnets-cidr : "10.11.32.0/21", availability_zone : "us-west-2b", access-layer : "public" },
    { subnets-cidr : "10.11.64.0/21", availability_zone : "us-west-2c", access-layer : "public" },
  ]
}