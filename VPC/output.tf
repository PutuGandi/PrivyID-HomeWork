output "vpc_id" {
    value      = aws_vpc.privyID.id
    description = "ID VPC"
}

output "private_subnet_id_A" {
    value      = aws_subnet.private.0.id
    description = "ID Subnet Private ap-southeast-1a"
}

output "private_subnet_id_B" {
    value      = aws_subnet.private.1.id
    description = "ID Subnet Private ap-southeast-1b"
}


output "public_subnet_id_A" {
    value      = aws_subnet.public.0.id
    description = "ID Subnet Public ap-southeast-1a"
}

output "public_subnet_id_B" {
    value      = aws_subnet.public.1.id
    description = "ID Subnet Public ap-southeast-1b"
}