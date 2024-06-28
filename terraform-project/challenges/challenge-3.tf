provider "aws" {
    region = var.region
}

variable "region" {
    type = string
    default = "us-east-1"
}

variable "vpc_cidr_range" {
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr_range" {
    type = string
    default = "10.0.1.0/24"
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.challenge-3-vpc.id
  cidr_block = var.subnet_cidr_range
  map_public_ip_on_launch = true
}


resource "aws_vpc" "challenge-3-vpc" {
  cidr_block = var.vpc_cidr_range
}