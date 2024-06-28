variable "region" {
    type = string
    default = "us-east-1"
}

provider "aws" {
  region = var.region
}

resource "aws_security_group" "allow_http_ssh" {
  name = "Allow SSH and HTTP"
  vpc_id = aws_vpc.challenge-3-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "ec2-instance-sg"
  }
}