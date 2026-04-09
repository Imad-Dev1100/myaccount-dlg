variable "environment" {
  type        = string
  description = "Deployment environment for Route53 resources."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID used for the private hosted zone association."
}

variable "zone_name" {
  type        = string
  description = "Private hosted zone name."
}

variable "record_name" {
  type        = string
  description = "DNS record name for the application."
}

variable "alb_dns_name" {
  type        = string
  description = "ALB DNS name used for the Route53 alias."
}

variable "alb_zone_id" {
  type        = string
  description = "ALB zone ID used for the Route53 alias."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to Route53 resources."
}
