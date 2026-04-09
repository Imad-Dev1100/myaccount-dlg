resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days

  tags = merge(var.default_tags, {
    Name = "${var.environment}-log-group"
  })
}

resource "aws_cloudwatch_metric_alarm" "errors" {
  alarm_name          = "${var.environment}-error-alarm"
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
