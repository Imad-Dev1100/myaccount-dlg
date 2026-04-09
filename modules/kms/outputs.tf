output "kms_key_id" {
  description = "The ID of the KMS key created for this environment."
  value       = aws_kms_key.main.key_id
}

output "kms_key_arn" {
  description = "The ARN of the KMS key created for this environment."
  value       = aws_kms_key.main.arn
}

output "kms_alias" {
  description = "The KMS alias name created for this environment."
  value       = aws_kms_alias.main.name
}
