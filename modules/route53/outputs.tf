output "zone_id" {
  description = "ID of the private Route53 hosted zone."
  value       = aws_route53_zone.private.zone_id
}

output "record_name" {
  description = "DNS record created for the application."
  value       = aws_route53_record.app.fqdn
}
