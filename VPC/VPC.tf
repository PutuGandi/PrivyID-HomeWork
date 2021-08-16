provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_vpc" "gandi" {
    cidr_block       = "10.0.0.0/16"
    enable_dns_hostnames = true
    tags = {
        Name = "Gandi-VPC"
    }
}
