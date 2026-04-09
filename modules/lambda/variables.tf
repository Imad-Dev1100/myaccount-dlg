variable "environment" {
  type        = string
  description = "Deployment environment for the Lambda function."
}

variable "function_name" {
  type        = string
  description = "Lambda function name."
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for the Lambda function."
}

variable "runtime" {
  type        = string
  description = "Lambda runtime."
}

variable "handler" {
  type        = string
  description = "Lambda handler."
}

variable "code_s3_bucket" {
  type        = string
  description = "S3 bucket containing the Lambda deployment package."
}

variable "code_s3_key" {
  type        = string
  description = "S3 key for the Lambda deployment package."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to Lambda resources."
}
