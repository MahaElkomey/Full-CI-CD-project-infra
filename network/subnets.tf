resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.mainVpc.id
  cidr_block = var.public-subnet-1-cidr
  availability_zone = var.az-1
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.mainVpc.id
  cidr_block = var.public-subnet-2-cidr
  availability_zone = var.az-2
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.mainVpc.id
  cidr_block = var.private-subnet-1-cidr
  availability_zone = var.az-1
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.mainVpc.id
  cidr_block = var.private-subnet-2-cidr
  availability_zone = var.az-2
}