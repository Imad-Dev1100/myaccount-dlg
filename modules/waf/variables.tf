variable "environment" {
  type        = string
  description = "Deployment environment for WAF."
}

variable "scope" {
  type        = string
  description = "WAF scope (REGIONAL or CLOUDFRONT)."
  default     = "REGIONAL"
}

variable "resource_arn" {
  type        = string
  description = "ARN of the resource to associate with the WAF Web ACL."
  default     = ""
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to WAF resources."
}
