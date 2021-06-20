output "arn" {
  description = "ARN of the created credential"
  value       = aws_codebuild_source_credential.this.arn
}
