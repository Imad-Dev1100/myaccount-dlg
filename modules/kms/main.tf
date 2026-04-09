data "aws_caller_identity" "current" {}

resource "aws_kms_key" "main" {
  description             = "Shared KMS key for the ${var.environment} environment."
  deletion_window_in_days = 30
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "EnableIAMUserPermissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid = "AllowUseOfTheKey"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_kms_key"
  })
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.environment}-shared"
  target_key_id = aws_kms_key.main.key_id
}
