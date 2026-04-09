resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  runtime       = var.runtime
  s3_bucket     = var.code_s3_bucket
  s3_key        = var.code_s3_key
  publish       = true

  tags = merge(var.default_tags, {
    Name = var.function_name
  })
}
