output "arn" {
  description = "ARN of the created CodeStar connection"
  value       = aws_codestarconnections_connection.this.arn
}

output "parameter" {
  description = "SSM parameter containing the ARN of the CodeStar connection"
  value       = aws_ssm_parameter.codestar_connection.name
}
