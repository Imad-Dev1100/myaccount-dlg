output "rest_api_id" {
  description = "API Gateway REST API ID."
  value       = aws_api_gateway_rest_api.this.id
}

output "invoke_url" {
  description = "Invoke URL for the deployed stage."
  value       = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${var.stage_name}"
}
