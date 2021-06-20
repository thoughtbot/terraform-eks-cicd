output "instance" {
  description = "The created project"
  value       = module.project.instance
}

output "name" {
  description = "Name of the created project"
  value       = module.project.name
}
