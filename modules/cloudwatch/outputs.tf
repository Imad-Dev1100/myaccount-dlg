output "log_group_name" {
  description = "Name of the CloudWatch log group created."
  value       = aws_cloudwatch_log_group.this.name
}

output "alarm_name" {
  description = "Name of the CloudWatch alarm created."
  value       = aws_cloudwatch_metric_alarm.errors.alarm_name
}
