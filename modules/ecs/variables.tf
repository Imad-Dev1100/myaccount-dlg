variable "environment" {
  type        = string
  description = "Deployment environment for the ECS cluster."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to ECS resources."
}
