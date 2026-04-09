variable "environment" {
  type        = string
  description = "Deployment environment for CloudWatch resources."
}

variable "log_group_name" {
  type        = string
  description = "Log group name to create."
}

variable "retention_in_days" {
  type        = number
  description = "Retention period for the log group."
  default     = 30
}

variable "metric_namespace" {
  type        = string
  description = "CloudWatch metric namespace."
}

variable "metric_name" {
  type        = string
  description = "CloudWatch metric name to alarm on."
}

variable "threshold" {
  type        = number
  description = "Alarm threshold value."
  default     = 1
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to CloudWatch resources."
}
