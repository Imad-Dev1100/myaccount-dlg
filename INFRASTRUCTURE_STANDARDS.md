# Infrastructure Standards

This document outlines the standards and best practices that have been implemented in this repository. All team members should follow these guidelines when extending or modifying the infrastructure.

---

## 1. Propagation Workflow

Code and infrastructure changes follow this deployment path:

```
DEV → TEST → STAGING → PROD (OFFLINE) → PROD (ONLINE)
```

Each environment has specific triggers, approvals, and automation:

| Environment | Purpose | Trigger | Approval | AWS Account | Notes |
|---|---|---|---|---|---|
| DEV | Development | PR/Merge to main | None | AWS_DEV | Automated testing, static analysis, terraform plan |
| TEST | QA | PR/Merge to main | None | AWS_QA | QA/Performance tests, security scans |
| STAGING | Pre-Prod | Manual | Lead | AWS_STAGING | UAT, exploratory tests, not customer facing |
| PROD (OFFLINE) | Production | Manual | PO/Lead | AWS_PROD | Blue/green, final validation, not customer facing |
| PROD (ONLINE) | Live | Manual | PO/Lead | AWS_PROD | Blue/green switch, live monitoring, customer facing |

---

## 2. Naming Conventions

All resource names must follow a consistent pattern to enhance readability and maintainability:

### Terraform Object Names
Use underscores to delimit multiple words:
```hcl
resource "aws_iam_policy" "example_policy" {
}
```

### Cloud Resource Names (AWS)
Use this naming convention:
```
<platform_code>_<environment>_<service>_<descriptor>_[suffix]
```

**Components:**
- **platform_code**: Short prefix for the platform (3-6 chars, no numbers)
  - Example: `gfdigital`
- **environment**: Dev, test, staging, or production
  - Examples: `dev`, `test`, `staging`, `production`
- **service**: The service or application name
  - Examples: `myaccount`
- **descriptor**: A meaningful descriptor for the resource
  - Examples: `kms_key`, `s3_appbucket`, `alb`, `role`
- **suffix**: Optional version or resource type indicator

### Examples
```
gfdigital_dev_myaccount_kms_key
gfdigital_dev_myaccount_s3_appbucket
gfdigital_dev_myaccount_alb
gfdigital_prod_myaccount_lambda_function
gfdigital_staging_myaccount_route53_private_zone
```

### Bucket Naming
S3 bucket names must be globally unique and follow:
```
<platform_code>-<environment>-<service>-<descriptor>
```

Examples:
```
gfdigital-dev-myaccount-app
gfdigital-prod-myaccount-data
```

---

## 3. Tagging Standards

**Tagging is mandatory** for all AWS resources. Tags help with organization, cost tracking, compliance, and automation.

### Mandatory Tags
Every resource must include these tags:

```hcl
tags = {
  application     = "myaccount-dlg"
  business_owner  = "Team Name or Person"
  cost_centre     = "111108"
  domain          = "cloud"
  environment     = var.environment
  support_group   = "Infrastructure Team"
  technical_owner = "Team Name or Person"
  used_for        = "infrastructure-provisioning"
}
```

### Tag Definitions
- **application**: Application name
- **business_owner**: Person or team responsible for business value
- **cost_centre**: Chargeback/billing cost centre code
- **domain**: Functional domain (e.g., cloud, web, mobile)
- **environment**: Deployment environment (dev, test, staging, production)
- **support_group**: Team providing operational support
- **technical_owner**: Person or team responsible for technical maintenance
- **used_for**: Purpose of the resource

### Implementation in Code
Tags are defined in `locals.tf` and automatically applied via `default_tags` in the provider:

```hcl
# In each environment's main.tf
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.default_tags
  }
}

# In each resource
tags = merge(var.default_tags, {
  Name = "gfdigital_dev_myaccount_kms_key"
})
```

---

## 4. Terraform Configuration Standards

### Version Constraints

**Terraform Version:**
```hcl
terraform {
  required_version = ">= 1.11.0, < 2.0.0"
}
```

**AWS Provider Version:**
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.4.0, < 7.0.0"
    }
  }
}
```

### Backend Configuration

All environments use S3 remote state with DynamoDB locking:

```hcl
backend "s3" {
  bucket         = "gfdigital-frontend-<env>-statefiles"
  key            = "terraform/<env>/terraform.tfstate"
  region         = "eu-west-1"
  dynamodb_table = "terraform-locks"
  encrypt        = true
}
```

**Backend Buckets by Environment:**
- DEV: `gfdigital-frontend-dev-statefiles`
- TEST: `gfdigital-frontend-test-statefiles`
- STAGING: `gfdigital-frontend-staging-statefiles`
- PROD: `gfdigital-frontend-production-statefiles`

### AWS Region
All resources are provisioned in `eu-west-1` (Ireland).

---

## 5. Module Structure

Reusable modules are located in `modules/` and must follow this structure:

```
modules/
├── <module_name>/
│   ├── main.tf          # Resource definitions
│   ├── variables.tf     # Input variable declarations
│   ├── outputs.tf       # Output value definitions
│   └── versions.tf      # Version and provider constraints
```

### Module Naming
Module folders use hyphens:
```
modules/vpc-endpoints/
modules/api-gateway/
modules/kms/
```

### Module Calls
Modules are called from environment `main.tf` files and pass necessary variables:

```hcl
module "kms" {
  source = "../../modules/kms"

  environment  = var.environment
  default_tags = local.default_tags
}
```

---

## 6. Environment Configuration

### Structure
Each environment has its own directory under `Terraform/`:

```
Terraform/
├── dev/
├── test/
├── staging/
└── production/
```

### Files in Each Environment

| File | Purpose |
|---|---|
| `main.tf` | Environment configuration and module calls |
| `variables.tf` | Input variable declarations |
| `outputs.tf` | Output values for other systems |
| `versions.tf` | Provider and backend configuration |
| `datasources.tf` | Data sources querying existing infrastructure |
| `locals.tf` | Local variables including default tags |
| `<env>.auto.tfvars` | Environment-specific variable values |
| `README.md` | Environment documentation |

### Auto-loaded Variables
Files named `<env>.auto.tfvars` are automatically loaded:
- `dev.auto.tfvars` in `Terraform/dev/`
- `test.auto.tfvars` in `Terraform/test/`
- `staging.auto.tfvars` in `Terraform/staging/`
- `production.auto.tfvars` in `Terraform/production/`

---

## 7. Secrets Management

**Never store secrets in plain text or commit them to the repository.**

### Best Practices

1. **Use AWS Secrets Manager** for application secrets
   - Encrypted with KMS keys
   - Versioned and rotatable
   - Accessed via IAM

2. **Use GitHub Secrets** for CI/CD credentials
   - Set via GitHub repository settings
   - Injected at runtime by GitHub Actions

3. **Use pre-commit hooks** to prevent accidental commits
   - Configured in `.pre-commit-config.yaml`

### Example: Secrets Module
The `modules/secrets/` module creates Secrets Manager secrets:

```hcl
resource "aws_secretsmanager_secret" "artifactory" {
  name        = "gfdigital_${var.environment}_myaccount_artifactory_credentials"
  kms_key_id  = var.kms_key_id
}
```

Before applying, replace `REPLACE_ME` with actual secret values.

---

## 8. File Organization

### Root Files
```
.
├── .github/              # GitHub Actions workflows
├── .gitignore
├── .pre-commit-config.yaml
├── .tflint.hcl
├── .releaserc.json
├── Terraform/            # Environment configurations
├── modules/              # Reusable modules
├── README.md
├── INFRASTRUCTURE_STANDARDS.md  # This file
├── TODAY.md              # Work summary
└── checkov.yml           # Policy scanning
```

### Branching Strategy
- `main`: Production-ready code
- `dev`: Development branch for features
- `feature/*`: Feature-specific branches

---

## 9. Code Quality and Validation

### Pre-commit Hooks
The `.pre-commit-config.yaml` enables automatic checks:

```yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
```

### Validation Commands
Before committing:

```bash
cd Terraform/<env>
terraform fmt -recursive
terraform validate
```

### Policy Scanning
Checkov scans for security and compliance issues:

```yaml
frameworks:
  - terraform
```

---

## 10. Community Modules

When using community modules from the Terraform Registry, stick to:
- `terraform-aws-modules`
- Azure modules

This ensures consistency and support within the organization.

---

## 11. Change Management

Infrastructure changes are integrated with ServiceNow (SNOW) for change tracking:
- Changes automatically create SNOW tickets
- Approvals are tracked and audited
- Blue/green deployments reduce risk
- Rollback procedures are automated

---

## 12. Deployment Checklist

Before deploying to any environment:

- [ ] All resource names follow the naming convention
- [ ] All mandatory tags are present in `locals.tf`
- [ ] Terraform validation passes: `terraform validate`
- [ ] Terraform formatting is correct: `terraform fmt`
- [ ] Pre-commit hooks pass
- [ ] Secrets are not committed
- [ ] Environment-specific variables are set correctly in `<env>.auto.tfvars`
- [ ] `terraform plan` output reviewed
- [ ] PR approved (for dev/test)
- [ ] Manual approval obtained (for staging/prod)

---

## 13. Common Placeholders to Replace

These placeholders should be replaced before applying:

### In `Terraform/*/main.tf`:
- `zone_name = "${var.environment}.internal.example.com"` → Replace with real domain
- `record_name = "app.${var.environment}.internal.example.com"` → Replace with real DNS name
- `code_s3_key = "${var.environment}/lambda/function.zip"` → Replace with correct S3 path
- `value = "example-value"` → Replace with real parameter value

### In `Terraform/*/locals.tf`:
- `business_owner = "TBD"` → Person or team name
- `technical_owner = "TBD"` → Person or team name
- `support_group = "TBD"` → Team name

### In `modules/secrets/main.tf`:
- `username = "REPLACE_ME"` → Actual Artifactory username
- `password = "REPLACE_ME"` → Actual Artifactory password
- `token = "REPLACE_ME"` → Actual GitHub PAT token

---

## 14. Questions or Issues?

Refer to:
- `TODAY.md` for work completed today
- `README.md` at repo root for overview
- Environment `README.md` files for specific environment notes
- Module documentation in each `modules/*/` folder

For questions, consult with the Infrastructure team or review the `CODEOWNERS` file for code review requirements.
