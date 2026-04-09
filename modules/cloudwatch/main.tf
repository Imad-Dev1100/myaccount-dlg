resource "aws_cloudwatch_log_group" "this" {
  name              = "/gfdigital/${var.environment}/myaccount/application"
  retention_in_days = var.retention_in_days

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_log_group"
  })
}

resource "aws_cloudwatch_metric_alarm" "errors" {
  alarm_name          = "gfdigital_${var.environment}_myaccount_error_alarm"
  alarm_description   = "Alarm when the ${var.environment} error metric exceeds threshold."
  namespace           = var.metric_namespace
  metric_name         = var.metric_name
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = var.threshold
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = []
}
