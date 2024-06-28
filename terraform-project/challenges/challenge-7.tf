variable "region" {
    type = string
    default = "us-east-1"
}

provider "aws" {
    region = var.region
}

resource "aws_eip" "my_eip" {
    tags = {
        Name = "my_eip"
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my-vpc.id
}

resource "aws_security_group" "SG" {
    name = "SG"
    vpc_id = aws_vpc.my-vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "my_instance" {
    ami = "ami-0c2b8ca1dad447f8a"
    instance_type = "t2.micro"
    security_groups = []
    subnet_id = aws_subnet.my-subnet.id
}

resource "aws_eip_association" "association" {
    instance_id = aws_instance.my_instance.id
    allocation_id = aws_eip.my_eip.id
}