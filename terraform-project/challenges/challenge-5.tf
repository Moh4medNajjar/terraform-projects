provider "aws" {
  region = var.region
}

variable "tags2" {
    type = map(string)
    default = {
        Name = "my-instance"
        Environment = "dev"
    }
}

resource "aws_instance" "challenge-5-instance" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance-type
    security_groups = [aws_security_group.allow_http_ssh.id]
    tags = var.tags2
}

