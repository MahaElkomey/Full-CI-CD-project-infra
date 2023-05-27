resource "aws_vpc" "mainVpc" {
  cidr_block = var.vpc-cidr
  enable_dns_hostnames = "true"
}