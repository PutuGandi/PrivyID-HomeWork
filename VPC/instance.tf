# Create NGINX
resource "aws_instance" "nginx" { 
	ami                     = "ami-03aad423811bbee56"
	instance_type           = "t2.micro"  
	vpc_security_group_ids  = [aws_security_group.SGPublic.id]
  key_name                = "Jumper-EC2"
	subnet_id               = aws_subnet.public.id

  tags = {
        Name = "nginx"
    }
}