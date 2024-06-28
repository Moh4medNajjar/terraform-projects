#####Variables############
# variables.ts
variable "Environment" {
  type        = string
  description = "The environment tag for resources"

  validation {
    condition     = contains(["development", "production"], var.Environment)
    error_message = "Environment must be development or production."
  }
}


variable "Owner" {
  type        = string
  description = "The owner tag for resources"
}

variable "ProjectName" { 
  type        = string
  description = "The project name"
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}
#####outputs############
# outputs.ts
locals {
  tags= merge({
    Environment = var.Environment
    Owner       = var.Owner
  },var.extra_tags)
}

output "tags" {
  value = local.tags
}

output "rds" {
  value = merge({
    name_prefix = "rds-${var.ProjectName}-${var.Environment}"
    tags = {
      Environment = var.Environment
      Owner       = var.Owner
      Resource    = "rds"
    }
  },local.tags)
}

output "ec2" {
  value = merge({
    name_prefix = "ec2-${var.ProjectName}-${var.Environment}"
    tags = {
      Environment = var.Environment
      Owner       = var.Owner
      Resource    = "ec2"
    }
  },local.tags)
}