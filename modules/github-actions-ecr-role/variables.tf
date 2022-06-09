variable "allow_github_pull_requests" {
  description = "Set to true to enable running from pull requests"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name of the IAM role"
  type        = string
}

variable "ecr_repositories" {
  description = "Name of the ECR repositories to which permissions should be granted"
  type        = list(string)
}

variable "github_branches" {
  description = "Branches allowed to push to this repository"
  type        = list(string)
}

variable "github_organization" {
  description = "Name of the GitHub organization which will assume this role"
  type        = string
}

variable "github_repository" {
  description = "Name of the GitHub repository which will assume this role"
  type        = string
}

variable "iam_oidc_provider_arn" {
  description = "ARN of the IAM OIDC provider for GitHub"
  type        = string
}
