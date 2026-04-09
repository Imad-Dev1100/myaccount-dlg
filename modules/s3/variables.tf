variable "environment" {
  type        = string
  description = "Deployment environment for the S3 bucket."
}

variable "bucket_prefix" {
  type        = string
  description = "Prefix used to create the S3 bucket name."
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ID for server-side encryption."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags to apply to the S3 bucket."
}
