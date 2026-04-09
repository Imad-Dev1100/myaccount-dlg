variable "environment" {
  type        = string
  description = "Deployment environment for SSM parameter store."
}

variable "name" {
  type        = string
  description = "SSM parameter name."
}

variable "description" {
  type        = string
  description = "SSM parameter description."
}

variable "parameter_type" {
  type        = string
  description = "SSM parameter type (String, StringList, SecureString)."
}

variable "value" {
  type        = string
  description = "Value of the SSM parameter."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to SSM resources."
}
