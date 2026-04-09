variable "environment" {
  type        = string
  description = "Deployment environment for the API Gateway."
}

variable "stage_name" {
  type        = string
  description = "Stage name for the API Gateway deployment."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to API Gateway resources."
}
