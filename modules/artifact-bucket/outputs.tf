output "arn" {
  description = "ARN of the created bucket"
  value       = aws_s3_bucket.this.arn
}

output "name" {
  description = "Name of the created bucket"
  value       = aws_s3_bucket.this.bucket
}
