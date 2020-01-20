provider "aws" {
  region  = var.region
  version = "~> 2.8"
}

terraform {
  required_version = ">= 0.12.13"
  required_providers {
    aws        = "~> 2.43"
    kubernetes = "~> 1.8"
    local      = "~> 1.3"
    template   = "~> 2.1"
    helm       = "~> 0.10"
    external   = "~> 1.2"
    tls        = "~> 2.1"
    archive    = "~> 1.2"
  }

  backend "s3" {
    region = "us-west-2"
    key    = "terraform.tfstate"
    bucket = "terraform-msk-zupshare"
  }
}