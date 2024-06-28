provider "aws" {
    region = "us-east-1"    
}

data "aws_ami" "amazon_linux" {
  most_recent = true
}

resource "aws_instance" "challenge-1-instance" {
  ami = "ami-01b799c439fd5516a"
  instance_type = data.aws_ami.amazon_linux.id
}