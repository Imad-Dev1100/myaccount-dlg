terraform {
  required_version = ">= 1.11.0, < 2.0.0"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.default_tags
  }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_vpc" "primary" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]
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

module "kms" {
  source = "../../modules/kms"

  environment  = var.environment
  default_tags = local.default_tags
}

module "iam" {
  source = "../../modules/iam"

  environment             = var.environment
  role_name               = "service-role-${var.environment}"
  assume_role_policy      = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns     = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  inline_policy_statements = []
  default_tags            = local.default_tags
}

module "ecs" {
  source = "../../modules/ecs"

  environment  = var.environment
  default_tags = local.default_tags
}

module "alb" {
  source = "../../modules/alb"

  environment = var.environment
  vpc_id      = data.aws_vpc.primary.id
  subnet_ids  = data.aws_subnets.vpce_subnet_ids.ids
  default_tags = local.default_tags
}

module "route53" {
  source = "../../modules/route53"

  environment  = var.environment
  vpc_id       = data.aws_vpc.primary.id
  zone_name    = "${var.environment}.internal.example.com"
  record_name  = "app.${var.environment}.internal.example.com"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
  default_tags = local.default_tags
}

module "lambda" {
  source = "../../modules/lambda"

  environment     = var.environment
  function_name   = "app-${var.environment}-function"
  role_arn        = module.iam.role_arn
  runtime         = "python3.11"
  handler         = "index.handler"
  code_s3_bucket  = module.s3.bucket_name
  code_s3_key     = "${var.environment}/lambda/function.zip"
  default_tags    = local.default_tags
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  environment      = var.environment
  log_group_name   = "/${var.environment}/application"
  metric_namespace = "${var.environment}-application"
  metric_name      = "Errors"
  threshold        = 1
  default_tags     = local.default_tags
}

module "api_gateway" {
  source = "../../modules/api-gateway"

  environment      = var.environment
  stage_name       = "${var.environment}"
  default_tags     = local.default_tags
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  environment         = var.environment
  origin_domain_name  = "${module.s3.bucket_name}.s3.amazonaws.com"
  default_root_object = "index.html"
  aliases             = []
  default_tags        = local.default_tags
}

module "ssm" {
  source = "../../modules/ssm"

  environment   = var.environment
  name          = "/${var.environment}/application/config"
  description   = "Application parameter for ${var.environment}."
  parameter_type = "String"
  value         = "example-value"
  default_tags  = local.default_tags
}

module "waf" {
  source = "../../modules/waf"

  environment  = var.environment
  scope        = "REGIONAL"
  resource_arn = module.alb.alb_arn
  default_tags = local.default_tags
}

module "s3" {
  source = "../../modules/s3"

  environment   = var.environment
  bucket_prefix = local.bucket_prefix
  kms_key_id    = module.kms.kms_key_id
  default_tags  = local.default_tags
}

module "secrets" {
  source = "../../modules/secrets"

  environment  = var.environment
  kms_key_id   = module.kms.kms_key_id
  default_tags = local.default_tags
}
