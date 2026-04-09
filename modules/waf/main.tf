resource "aws_wafv2_web_acl" "this" {
  name        = "gfdigital_${var.environment}_myaccount_web_acl"
  scope       = var.scope
  description = "WAFv2 web ACL for ${var.environment} environment."

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "gfdigital_${var.environment}_myaccount_web_acl"
    sampled_requests_enabled   = true
  }

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_waf_acl"
  })
}

resource "aws_wafv2_web_acl_association" "this" {
  count      = var.resource_arn != "" ? 1 : 0
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}
