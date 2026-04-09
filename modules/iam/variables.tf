variable "environment" {
  type        = string
  description = "Deployment environment for the IAM module."
}

variable "role_name" {
  type        = string
  description = "Name of the IAM role to create."
}

variable "assume_role_policy" {
  type        = string
  description = "IAM assume role policy document."
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "Managed policy ARNs to attach to the role."
  default     = []
}

variable "inline_policy_statements" {
  type        = list(any)
  description = "Inline IAM policy statements to attach to the role."
  default     = []
}

variable "default_tags" {
  type        = map(string)
  description = "Tags to apply to IAM resources."
}
