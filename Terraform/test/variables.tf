variable "aws_region" {
  type        = string
  description = "AWS region for resources."
  default     = "eu-west-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
}
