#########################################################################################
#################################### Variables ##########################################
#########################################################################################

variable "region_1" {
  type = string
  default = "us-east-1"
}

variable "region_2" {
  type = string
  default = "us-west-1"
}

variable "cidr_range_east" {
  type = string
  default = "10.10.0.0/16"
}

variable "public_subnets_east" {
  type = list(string)
  default = [ "10.10.0.0/24", "10.10.1.0/24" ]
}

variable "database_subnets_east" {
  type = list(string)
  default = [ "10.10.8.0/24", "10.10.9.0/24" ]
}

variable "cidr_range_west" {
  type = string
  default = "10.11.0.0/16"
}

variable "public_subnets_west" {
  type = list(string)
  default = [ "10.11.0.0/24", "10.11.1.0/24" ]
}

variable "database_subnets_west" {
  type = list(string)
  default = [ "10.11.8.0/24", "10.11.9.0/24" ]
}

#########################################################################################
#################################### Providers ##########################################
#########################################################################################

provider "aws" {
  region = var.region_1
  alias = "east"
}

provider "aws" {
    region = var.region_2
    alias = "west"
}

#########################################################################################
#################################### Data Sources #######################################
#########################################################################################

data "aws_availability_zones" "azs_east" {
  provider = aws.east
}

data "aws_availability_zones" "azs_west" {
    provider = aws.west
}

#########################################################################################
#################################### Modules ############################################
#########################################################################################

module "vpc-east" {
  source = "vpc_modules/.."
  version = "value"

  name = "production-vpc-east"
  cidr = var.cidr_range_east

  azs = slice(data.aws_availability_zones.azs.names, 0, 2)
  public_subnets = var.public_subnets_east
  database_subnets = var.database_subnets_east

  database_subnet_group_tags = {
    subnet_type = "database"
  }

  providers = {
    aws = aws.east
  }

  tags = {
    environment = "prod"
    region = "east"
    team = "infra"
  }
}

module "vpc-west" {
  source = "vpc_modules/.."
  version = "value"

  name = "production-vpc-west"
  cidr = var.cidr_range_west

  azs = slice(data.aws_availability_zones.azs.names, 0, 2)
  public_subnets = var.public_subnets_west
  database_subnets = var.database_subnets_west

  database_subnet_group_tags = {
    subnet_type = "database"
  }

  providers = {
    aws = aws.west
  }

  tags = {
    environment = "prod"
    region = "west"
    team = "infra"
  }
}

#########################################################################################
#################################### Outputs ############################################
#########################################################################################

output "vpc_id_east" {
  value = module.vpc_east.vpc_id
}

output "vpc_id_west" {
  value = module.vpc_west.vpc_id
}