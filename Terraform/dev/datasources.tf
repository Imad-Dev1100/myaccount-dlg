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
