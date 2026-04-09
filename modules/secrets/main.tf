resource "aws_secretsmanager_secret" "artifactory" {
  name        = "artifactory-credentials-${var.environment}"
  description = "Artifactory credentials for the ${var.environment} environment."
  kms_key_id  = var.kms_key_id

  tags = merge(var.default_tags, {
    Name = "artifactory-credentials-${var.environment}"
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
  name        = "github-pat-${var.environment}"
  description = "GitHub PAT secret for the ${var.environment} environment."
  kms_key_id  = var.kms_key_id

  tags = merge(var.default_tags, {
    Name = "github-pat-${var.environment}"
  })
}

resource "aws_secretsmanager_secret_version" "github_pat" {
  secret_id     = aws_secretsmanager_secret.github_pat.id
  secret_string = jsonencode({
    token = "REPLACE_ME"
  })
}
