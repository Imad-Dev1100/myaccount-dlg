output "environment" {
  value = var.environment
}

output "vpc_id" {
  description = "Primary VPC ID for the dev environment."
  value       = data.aws_vpc.primary.id
}

output "kms_key_id" {
  description = "Shared KMS key ID used for encryption."
  value       = module.kms.kms_key_id
}

output "s3_bucket_name" {
  description = "Name of the environment S3 bucket."
  value       = module.s3.bucket_name
}

output "artifactory_secret_arn" {
  description = "ARN of the artifactory credentials secret."
  value       = module.secrets.artifactory_secret_arn
}

output "github_pat_secret_arn" {
  description = "ARN of the GitHub PAT secret."
  value       = module.secrets.github_pat_secret_arn
}

output "vpce_ids" {
  description = "VPC endpoint IDs created in the dev environment."
  value       = module.vpc_endpoints.endpoint_ids
}
