resource "aws_secretsmanager_secret" "artifactory" {
  name        = "gfdigital_${var.environment}_myaccount_artifactory_credentials"
  description = "Artifactory credentials for the ${var.environment} environment."
  kms_key_id  = var.kms_key_id

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_artifactory_secret"
  })
}

resource "aws_secretsmanager_secret_version" "artifactory" {
  secret_id     = aws_secretsmanager_secret.artifactory.id
  secret_string = jsonencode({
    username = "REPLACE_ME"
    password = "REPLACE_ME"
  })
}

resource "aws_secretsmanager_secret" "github_pat" {
  name        = "gfdigital_${var.environment}_myaccount_github_pat"
  description = "GitHub PAT secret for the ${var.environment} environment."
  kms_key_id  = var.kms_key_id

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_github_secret"
  })
}

resource "aws_secretsmanager_secret_version" "github_pat" {
  secret_id     = aws_secretsmanager_secret.github_pat.id
  secret_string = jsonencode({
    token = "REPLACE_ME"
  })
}
