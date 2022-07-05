variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "eks_deploy_role_name" {
  type        = string
  description = "Name of role for EKS access"
  default     = ""
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

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created AWS resources"
  default     = {}
}
