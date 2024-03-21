output "arn" {
  description = "ARN of the created IAM role"
  value       = aws_iam_role.this.arn
}

output "name" {
  description = "Name of the created IAM role"
  value       = aws_iam_role.this.name
}
