variable "environment" {
  type        = string
  description = "The deployment environment for secrets."
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ID used to encrypt secrets."
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to Secrets Manager secrets."
}
