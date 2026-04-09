variable "environment" {
  type        = string
  description = "Deployment environment for CloudFront."
}

variable "origin_domain_name" {
  type        = string
  description = "Origin domain name for the CloudFront distribution."
}

variable "default_root_object" {
  type        = string
  description = "Default root object for CloudFront."
  default     = "index.html"
}

variable "origin_protocol_policy" {
  type        = string
  description = "Protocol policy for the origin."
  default     = "https-only"
}

variable "aliases" {
  type        = list(string)
  description = "Alternate domain names for CloudFront."
  default     = []
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to CloudFront resources."
}
