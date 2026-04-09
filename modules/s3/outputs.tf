output "bucket_name" {
  description = "The name of the S3 bucket created for the environment."
  value       = aws_s3_bucket.app.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket created for the environment."
  value       = aws_s3_bucket.app.arn
}
