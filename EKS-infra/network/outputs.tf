output vpc_id {
    value = aws_vpc.mainVpc.id
}

output vpc_cidr {
    value = aws_vpc.mainVpc.cidr_block
}

output public_subnet_1_id {
    value = aws_subnet.public1.id
}

output public_subnet_2_id {
    value = aws_subnet.public2.id
}

output private_subnet_1_id {
    value = aws_subnet.private1.id
}

output private_subnet_2_id {
    value = aws_subnet.private2.id
}