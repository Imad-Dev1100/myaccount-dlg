output "lambda_function_arn" {
  description = "ARN of the Lambda function created by this module."
  value       = aws_lambda_function.this.arn
}

output "function_name" {
  description = "Name of the Lambda function created by this module."
  value       = aws_lambda_function.this.function_name
}
