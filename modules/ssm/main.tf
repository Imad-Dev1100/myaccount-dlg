resource "aws_ssm_parameter" "this" {
  name        = var.name
  description = var.description
  type        = var.parameter_type
  value       = var.value

  tags = merge(var.default_tags, {
    Name = var.name
  })
}
