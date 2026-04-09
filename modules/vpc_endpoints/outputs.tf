output "endpoint_ids" {
  description = "IDs of the VPC endpoints created for the environment."
  value       = [
    aws_vpc_endpoint.secretsmanager.id,
    aws_vpc_endpoint.ssm.id,
  ]
}

output "security_group_id" {
  description = "Security group used by the VPC interface endpoints."
  value       = aws_security_group.vpce.id
}
