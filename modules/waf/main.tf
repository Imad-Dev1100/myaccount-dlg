resource "aws_wafv2_web_acl" "this" {
  name        = "${var.environment}-web-acl"
  scope       = var.scope
  description = "WAFv2 web ACL for ${var.environment} environment."

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.environment}-web-acl"
    sampled_requests_enabled   = true
  }

  tags = merge(var.default_tags, {
    Name = "waf-${var.environment}"
  })
}

resource "aws_wafv2_web_acl_association" "this" {
  count      = var.resource_arn != "" ? 1 : 0
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}
