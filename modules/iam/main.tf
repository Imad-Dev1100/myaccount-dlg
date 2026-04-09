resource "aws_iam_role" "service" {
  name               = "gfdigital_${var.environment}_myaccount_service_role"
  assume_role_policy = var.assume_role_policy

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_service_role"
  })
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = toset(var.managed_policy_arns)
  role       = aws_iam_role.service.name
  policy_arn = each.value
}

resource "aws_iam_role_policy" "inline" {
  count = length(var.inline_policy_statements) > 0 ? 1 : 0

  name = "${aws_iam_role.service.name}-inline-policy"
  role = aws_iam_role.service.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = var.inline_policy_statements
  })
}
