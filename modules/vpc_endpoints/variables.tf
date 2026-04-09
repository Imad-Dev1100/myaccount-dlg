variable "environment" {
  type        = string
  description = "The deployment environment for the VPC endpoints."
}

variable "aws_region" {
  type        = string
  description = "AWS region where the VPC endpoints are created."
}

variable "vpc_id" {
  type        = string
  description = "ID of the existing VPC where endpoints are deployed."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs used for interface VPC endpoints."
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC to restrict VPC endpoint ingress."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to VPC endpoint resources."
}
