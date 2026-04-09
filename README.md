# Infrastructure Provisioning Repository

This repository contains Terraform infrastructure provisioning for the Frontend Customer Web and BFF Customer projects.

## Structure

- `.github/workflows/`: CI/CD workflows for Terraform.
- `Terraform/`: Environment-specific Terraform configurations for dev, test, staging, and production.
- `modules/`: Reusable Terraform modules for common AWS infrastructure patterns.

## Environments

Each environment directory contains:
- `main.tf`
- `variables.tf`
- `outputs.tf`
- `versions.tf`
- `datasources.tf`
- `locals.tf`
- `<env>.auto.tfvars`

## Modules

- `ecs`
- `alb`
- `route53`
- `lambda`
- `s3`
- `cloudfront`
- `api-gateway`
- `cloudwatch`
- `iam`
- `kms`
- `ssm`
- `waf`
- `vpc_endpoints`
- `secrets`

## Notes

- Replace placeholder values such as the Lambda S3 package key and secret strings before applying.
- `checkov.yml` is configured to validate Terraform frameworks.
- `.tflint.hcl` enables the AWS plugin for TFLint.
