output "role_arn" {
  description = "ARN of the IAM role created by this module."
  value       = aws_iam_role.service.arn
}

output "role_name" {
  description = "Name of the IAM role created by this module."
  value       = aws_iam_role.service.name
}
