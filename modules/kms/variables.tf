variable "environment" {
  type        = string
  description = "Deployment environment for the KMS module."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags to apply to all resources managed by the module."
}
