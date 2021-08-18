# Create NGINX
resource "aws_instance" "nginx" { 
	ami                     = "ami-03aad423811bbee56"
	instance_type           = "t2.micro"  
	vpc_security_group_ids  = [aws_security_group.SGPublic.id]
  key_name                = "Jumper-EC2"
	subnet_id               = aws_subnet.public.0.id

  tags = {
        Name = "nginx"
    }

  user_data = file("script.sh")
}

# Create bastionhost
resource "aws_instance" "bastionhost" { 
	ami                     = "ami-03aad423811bbee56"
	instance_type           = "t2.micro"  
	vpc_security_group_ids  = [aws_security_group.SGPublic.id]
  key_name                = "Jumper-EC2"
	subnet_id               = aws_subnet.public.0.id

  tags = {
        Name = "Bastion-Host"
    }
}


