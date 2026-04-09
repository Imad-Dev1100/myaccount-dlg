resource "aws_security_group" "vpce" {
  name        = "gfdigital_${var.environment}_myaccount_vpce_sg"
  description = "Security group for VPC interface endpoints in the ${var.environment} environment."
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_vpce_sg"
  })
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = [aws_security_group.vpce.id]
  private_dns_enabled = true

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_vpce_secretsmanager"
  })
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = [aws_security_group.vpce.id]
  private_dns_enabled = true

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_vpce_ssm"
  })
}
