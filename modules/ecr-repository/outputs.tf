output "arn" {
  description = "ARN of the created ECR repository"
  value       = aws_ecr_repository.this.arn
}

output "base_mirror_arn" {
  description = "ARN of the ECR repository created to mirror the base image"
  value       = aws_ecr_repository.base_mirror.arn
}

output "base_mirror_name" {
  description = "Name of the ECR repository created to mirror the base image"
  value       = aws_ecr_repository.base_mirror.name
}

output "name" {
  description = "The name of the created ECR repository"
  value       = aws_ecr_repository.this.name
}
