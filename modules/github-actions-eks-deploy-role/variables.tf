variable "allow_github_pull_requests" {
  description = "Set to true to enable running from pull requests"
  type        = bool
  default     = false
}

variable "cluster_names" {
  type        = list(string)
  description = "Names of the EKS clusters to which this role can deploy"
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

variable "managed_prometheus_namespace_prefix" {
  description = "Allowed prefix for AMP rules; defaults to GitHub repository"
  type        = string
  default     = null
}

variable "managed_prometheus_workspace_ids" {
  description = "Allowed AMP workspace; disabled if empty"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name of the IAM role"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created AWS resources"
  default     = {}
}
