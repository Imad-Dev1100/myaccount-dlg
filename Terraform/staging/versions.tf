terraform {
  required_version = ">= 1.11.0, < 2.0.0"

  backend "s3" {
    bucket         = "gfdigital-frontend-staging-statefiles"
    key            = "terraform/staging/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.4.0, < 7.0.0"
    }
  }
}
