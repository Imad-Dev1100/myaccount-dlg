resource "aws_lambda_function" "this" {
  function_name = "gfdigital_${var.environment}_myaccount_function"
  role          = var.role_arn
  handler       = var.handler
  runtime       = var.runtime
  s3_bucket     = var.code_s3_bucket
  s3_key        = var.code_s3_key
  publish       = true

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_lambda_function"
  })
}
