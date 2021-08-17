resource "aws_vpc" "privyID" {
    cidr_block       = "10.10.0.0/16"
    enable_dns_hostnames = true
    tags = {
        Name = "PrivyID-VPC"
    }
}

#---------------------------
#---Create Private Subnet---
#--------------------------
resource "aws_subnet" "private" {
    count                   = length(var.private_subnets)
    vpc_id                  = aws_vpc.privyID.id
    #cidr_block              = var.private_subnets
    cidr_block              = var.private_subnets[count.index]
    availability_zone       = var.aws_availability_zones[count.index]
    map_public_ip_on_launch = false

    tags = {
        Name = var.private_names[count.index]
    }
}

#---------------------------
#---Create Public Subnet----
#---------------------------
resource "aws_subnet" "public" {
    count                   = length(var.public_subnets)
    vpc_id                  = aws_vpc.privyID.id
    #cidr_block              = var.public_subnets
    cidr_block              = var.public_subnets[count.index]
    availability_zone       = var.aws_availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = var.public_names[count.index]
    }
}

#-----------------------------
#---Create Internet Gateway---
#-----------------------------
resource "aws_internet_gateway" "igwPrivyID" {
    vpc_id = aws_vpc.privyID.id

    tags = {
      Name = "igw-GandiVPC"
    }
}

#------------------------------------------
#---Create Route Table for Public Subnet---
#------------------------------------------
resource "aws_route_table" "routepublic" {
    vpc_id = aws_vpc.privyID.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igwPrivyID.id
    }

    tags = {
      Name = "RouteTable-Public"
    }
}   

resource "aws_route_table_association" "routepublicassociation" {
    count          = length(var.public_subnets)
    subnet_id      = element(aws_subnet.public.*.id, count.index)
    route_table_id = aws_route_table.routepublic.id
}

#----------------------------------------------
#---Cretae NAT Gateway on AZ ap-shouteast-1a---
#----------------------------------------------
resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
    allocation_id   = aws_eip.nat_gateway.id
    subnet_id       = element(aws_subnet.public.*.id, 0)

    tags = {
        "Name" = "NAT-GW-PrivyID"
  }
}

#------------------------------------------------------------------
#---Cretae Route Table directing to NAT Gateway for Private Subnet---
#------------------------------------------------------------------
resource "aws_route_table" "routeprivate" {
    vpc_id = aws_vpc.privyID.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.natgw.id
    }

    tags = {
      Name = "RouteTable-Private"
    }
}   

resource "aws_route_table_association" "routeprivateassociation" {
    subnet_id      = element(aws_subnet.private.*.id, 0)
    route_table_id = aws_route_table.routeprivate.id
}