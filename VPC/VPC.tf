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
    vpc_id                  = aws_vpc.privyID.id
    cidr_block              = var.private_subnets
    availability_zone       = var.aws_availability_zones
    map_public_ip_on_launch = false

    tags = {
        Name = "Private Subent PrivyID"
    }
}

#---------------------------
#---Create Public Subnet----
#---------------------------
resource "aws_subnet" "public" {
    vpc_id                  = aws_vpc.privyID.id
    cidr_block              = var.public_subnets
    availability_zone       = var.aws_availability_zones
    map_public_ip_on_launch = true

    tags = {
        Name = "Public Subnet PrivyID"
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
    subnet_id      = aws_subnet.public.id
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
    subnet_id       = aws_subnet.public.id

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
    subnet_id      = aws_subnet.private.id
    route_table_id = aws_route_table.routeprivate.id
}