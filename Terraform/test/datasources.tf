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
