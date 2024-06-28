provider "aws" {
  region = "us-east-1"
}

variable "instance-type" {
  type = string
  default = "t2.micro"
}

variable "tags" {
    type = map(string)
    default = {
        Name = "my_instance"
        Environment = "dev"
    }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "challenge-2-instance" {
  instance_type = var.instance-type
  ami = data.aws_ami.amazon_linux.id
  tags = var.tags
}