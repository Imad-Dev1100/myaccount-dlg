variable "environment" {
  type        = string
  description = "Deployment environment for the ALB."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the ALB will be deployed."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the ALB listeners."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to ALB resources."
}
