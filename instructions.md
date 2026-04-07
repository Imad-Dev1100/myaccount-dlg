Github Repository for infrastructure provisioning for Frontend and BFF
 Folder structure
1)Terraform
2) Frontend Customer Web
3)Web BFF Customer
Core File Structure:
Foundational files to organize our infrastructure code effectively 
 Default Tags (default_tags)
VPC Endpoints (vpc_endpoints)
Secrets (secrets)
 S3 Buckets (s3_buckets)
Terraform Version Constraint
AWS Provider Configuration
S3 Backend (State Management)
AWS Provider Settings
 

Github Repository for infrastructure provisioning for Frontend and BFF
Direct-Line-Group/gfui-web-digitisation-terraform-infra: Frontend Customer Web Deploy

Direct-Line-Group/gfui-web-ui-customer-qnb: Green Flag Quote and Buy Web UI (under development)

Direct-Line-Group/gfui-web-bff-customer: Green Flag Quote & Buy BFF for Customer-Web ( Under Development 

 

 Folder structure
 

The recommended Terraform folder structure for GitHub Actions is to separate workflows, modules, and environments clearly. This ensures reusable code, easier maintenance, and targeted deployments

1)Terraform
Direct-Line-Group/gfui-web-digitisation-terraform-infra: Frontend Customer Web Deploy



.
├── .github/workflows/
│   └── deploy-terraform.yml
│   └── merge-terraform.yml
│   └── pull-request-pre-commit.yml
│   └── pull-request-terraform.yaml
│   └── release-terraform.yaml
├── Terraform/
│   ├── dev/
│   │   ├── README.md
│   │   └── datasources.tf
│   │   └── locals.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── dev.auto.tfvars
│   │   └── variables.tf
│   │   └── versions.tf
│   ├── test/
│   │   ├── README.md
│   │   └── datasources.tf
│   │   └── locals.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── test.auto.tfvars
│   │   └── variables.tf
│   │   └── versions.tf
│   ├── staging/
│   │   ├── README.md
│   │   └── datasources.tf
│   │   └── locals.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── staging.auto.tfvars
│   │   └── variables.tf
│   │   └── versions.tf
│   └── production/
│   │   ├── README.md
│   │   └── datasources.tf
│   │   └── locals.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── prod.auto.tfvars
│   │   └── variables.tf
│   │   └── versions.tf
├── modules/
│    └── ecs
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   │   └── versions.tf
│    └── alb
│    └── route53
│    └── lambda
│    └── s3
│    └── cloudfront
│    └── api gateway
│    └── cloudwatch
│    └── iam 
│    └── kms
│    └── ssm
│    └── waf
├──.releaserc.json
├── README.md
└── checkov.yml
└── .gitignore
└──.pre-commit-config.yaml
└──.tflint.hcl
└── CODEOWNERS
 

2) Frontend Customer Web
Direct-Line-Group/gfui-web-ui-customer-qnb: Green Flag Quote and Buy Web UI (under development)



├── .github/workflows/
│   ├── pull-request-validation.yml
│   ├── build-push-dev-ui.yml
│   ├── deploy-ui.yml
├── SRC/
├── Test/
 

3)Web BFF Customer
Direct-Line-Group/gfui-web-bff-customer: Green Flag Quote & Buy BFF for Customer-Web ( Under Development )



├── .github/workflows/
│   ├── pull-request-validation.yml
│   ├── build-push-dev-bff.yml    
│   ├── deploy-bff.yml
├── SRC/
├── Test/
This structure promotes modularity and reusability making it easier to manage our Infrastructure as code and integrate it with automated workflows

 

Core File Structure:
 

.github/workflows/:  This directory contains  GitHub Actions workflow files (e.g deploy_ui.yml). These files define the steps for our CI/CD pipeline, including running Terraform commands.

Terraform/ : This directory contains all  Terraform configuration files. Within this, we  can further organize our files for better management:

Environment-specific directories: Within Terraform we have created separate subdirectories for each environment (e.g., dev, QA/test staging, prod). Each environment directory would contain its own main.tf,output.tf ,env.auto.tfvars, variables.tf, and versions.tf 

Modules directory: Terraform modules are stored in modules/ subdirectory within terraform/. Each modules has its  own dedicated folder containing its main.tf ,outputs.tf,variables.tf and versions.tf

 

Foundational files to organize our infrastructure code effectively 
 

main.tf main.tf is the starting point where logic of infrastructure as code is implemented. This file includes resources and can also include datasources and locals. It also contains Terraform Providers and an initial modules which are required for Infrastructure Provisioning

variables.tf it contains the variables declaration used in resource blocks . It incudes definition of input variable for our configuration mentioning their types, description and default values.

output.tf This file extracts and displays information about the resources  provisioned, such as IDs, ARNs, or custom values, making it easier to understand the deployed infrastructure or to integrate with other systems.

*.tfvars These files are used to assign values to input variables declared in terraform configuration files.

.terraform.lock.hcl  The .terraform.lock.hcl file's primary purpose is to lock the provider versions to ensure that all team members and CI/CD systems use identical versions. 

This prevents inconsistencies arising from different versions. The file includes detailed version information and a list of cryptographic hashes corresponding to the provider's packages for various platforms and architectures.

 

Datasources.tf This Terraform configuration file defines data sources that query existing AWS infrastructure rather than creating new resources



data "aws_vpc" "primary" {
  filter {
    name   = "tag:Name"
    values = ["awsdlgctgfdigital${var.environment}-vpc"]
  }
}
data "aws_subnets" "vpce_subnet_ids" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.primary.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*VPC Endpoint*"]
  }
}
This file retrieves information about networking components in AWS Account for the "dev" environment, specifically VPC and subnet details

VPC datasource Its purpose is to find existing VPC and searches for VPC with specific tag name and  VPC ID can be referenced elsewhere as data.aws_vpc.primary.id

VPC Endpoint Subnets: It retrieves all subnets designated for VPC Endpoints it filters with  VPC found above and "VPC Endpoint" somewhere in the subnet's Name tag (wildcard matching) . It returns a list of subnet IDs accessible via data.aws_subnets. vpce_subnet_ids. ids

 

Find the VPC using its Name tag

Use that VPC's ID to find subnets within it

Filter subnets by their purpose (VPC Endpoints vs Applications)

locals.tf This Terraform locals. tf file defines local variables for the dev environment in our gitrepo

 Default Tags (default_tags)
A comprehensive set of AWS resource tags for governance, cost tracking, and organization:

Application identifiers: application, applicationshortname 

Ownership: business_owner, technical_owner , support_group 

Classification: confidentiality  department  domain 

Financial: cost_centre (111108) - for chargeback/billing

Environment tracking: environment

Infrastructure metadata: provisioned_by (terraform), repo (source repository name)

Project context: project 

These tags would be applied to all AWS resources created in this environment for consistent resource management.

 

main.tf This main.tf file is the main Terraform configuration for the development environment of the gfui-web-digitisation-frontend-deploy infrastructure. It manages multiple infrastructure modules to set up AWS resources.

VPC Endpoints (vpc_endpoints)
Creates VPC endpoints to enable private connectivity to AWS services without going through the internet:

Uses the primary VPC

Restricts ingress to the VPC's CIDR block

Deployed in specific VPC endpoint subnets

KMS Provisions AWS Key Management Service keys for encryption:

Creates a shared KMS key for the environment

Used by other modules for encrypting data at rest

Secrets (secrets)
Manages secrets in AWS Secrets Manager:

Artifactory credentials for integrations (username/password for artifact repository)

GitHub PAT (Personal Access Token) for resetting/accessing GitHub

Encrypted using the shared KMS key

Supports secret versioning

 S3 Buckets (s3_buckets)
Creates S3 buckets for storage needs:

Server-side encryption with the shared KMS key

Environment-specific naming

output.tf This Terraform outputs file exposes important values from the dev environment's infrastructure that can be referenced by other Terraform configurations or displayed after deployment.

versions.tf  This is a Terraform configuration file that defines version constraints, provider settings, and state management for the dev environment of gfui-web-digitisation-frontend infrastructure

 

Terraform Version Constraint
Requires Terraform version 1.11.0 or higher, but below version 2.0.0

This ensures compatibility and prevents breaking changes from major version upgrades

AWS Provider Configuration
Specifies the AWS provider from HashiCorp's registry

Requires version 6. 4.0 or higher, but below 7.0.0

S3 Backend (State Management)
Remote State: Stores Terraform state file in an S3 bucket named gfdigital-fronentd-dev-statefiles

Region: Uses AWS eu-west-1 (Ireland) region

Locking: use_lockfile = true enables state locking to prevent concurrent modifications

AWS Provider Settings
Region: All AWS resources will be created in eu-west-1

Default Tags: Automatically applies tags defined in local.default_tags to all AWS resources for consistent resource tagging (useful for cost allocation, compliance, and resource management)

This file serves as the foundation for the dev environment's Terraform configuration, ensuring:

 Consistent tooling versions across team members

 Remote state management with locking for team collaboration

 Centralized provider configuration

Automatic resource tagging for governance

Modules This Terraform configuration file defines an AWS ECR (Elastic Container Registry) module.

This module creates and configures AWS ECR repositories for storing Docker container images, with specific access controls and lifecycle policies.
