output "instance" {
  description = "The created project"
  value       = aws_codebuild_project.this
}

output "name" {
  description = "Name of the created project"
  value       = aws_codebuild_project.this.name
}
