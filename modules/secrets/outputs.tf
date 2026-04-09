output "artifactory_secret_arn" {
  description = "ARN for the artifactory credentials secret."
  value       = aws_secretsmanager_secret.artifactory.arn
}

output "github_pat_secret_arn" {
  description = "ARN for the GitHub PAT secret."
  value       = aws_secretsmanager_secret.github_pat.arn
}
