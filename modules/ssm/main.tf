resource "aws_ssm_parameter" "this" {
  name        = "/gfdigital/${var.environment}/myaccount/config"
  description = var.description
  type        = var.parameter_type
  value       = var.value

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_parameter"
  })
}
