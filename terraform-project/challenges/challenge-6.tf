provider "aws" {
  region = var.region
}

variable "region" {
    type = string
    default = "us-east-1"
}
variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr_block" {
  type = string
  default = "10.0.1.0/24"
}
variable "private_subnet_cidr_block" {
  type = string
  default = "10.0.2.0/24"
}
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr_block
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.private_subnet_cidr_block
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my-vpc.id  
}

resource "aws_route_table_association" "aws_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.my-vpc.id

    route {
        cidr_block = var.public_subnet_cidr_block
        gateway_id = aws_internet_gateway.igw.id
    }

    route {
        cidr_block = var.private_subnet_cidr_block
    }
}



