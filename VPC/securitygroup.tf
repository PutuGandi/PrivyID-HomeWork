
#---------------------------
#---Create security group---
#---------------------------
resource "aws_security_group" "SGPublic" {
    vpc_id       = aws_vpc.privyID.id
    name         = "SGPublic"
    description  = "SGPublic"

    # allow ingress of port 22
    ingress {
        cidr_blocks = ["180.249.185.94/32"]
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        #from_port   = 0
        #to_port     = 0
        #protocol    = "-1"
        #cidr_blocks = ["0.0.0.0/0"]
    } 

    # allow ingress of port 80
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
    } 
    
    
    # allow egress of all ports
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }


    tags = {
        Name = "SGPublic"
        Description = "SGPublics"
    }
}

resource "aws_security_group" "SGPrivate" {
    vpc_id       = aws_vpc.privyID.id
    name         = "SGPrivate"
    description  = "SGPrivate"

    # allow ingress of port 22
    ingress {
        security_groups = [aws_security_group.SGPublic.id]
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
    }

    ingress {
        security_groups = [aws_security_group.SGPublic.id]
        #cidr_blocks = ["${aws_instance.nginx.private_ip}"]
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
    }

    # allow egress of all ports
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }


    tags = {
        Name = "SGPrivate"
        Description = "SGPrivate"
    }
}
