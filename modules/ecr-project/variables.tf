variable "artifacts_bucket" {
  description = "Name of the S3 bucket in which artifacts are stored"
  type        = string
}

variable "buildspec" {
  description = "Override the buildspec for this project"
  type        = string
  default     = null
}

variable "codestar_connection" {
  type        = string
  description = "SSM parameter containing the ARN of the CodeStar connection"
}

variable "ecr_repository" {
  type        = string
  description = "ECR repository to which images should be pushed"
}

variable "enable_github_webhook" {
  type        = bool
  description = "Set to false if the GitHub token can't manage webhooks"
  default     = true
}

variable "github_repository" {
  type        = string
  description = "Full name of the GitHub repository at which source is found"
}

variable "name" {
  type        = string
  description = "Name for this CodeBuild project"
}

variable "namespace" {
  type        = list(string)
  description = "Prefix to apply to created resources"
  default     = []
}

variable "policies" {
  type        = map(object({ arn = string }))
  description = "Additional policies for this CodeBuild project's role"
  default     = {}
}

variable "secondary_ecr_repositories" {
  type        = list(string)
  description = "Additional ECR repositories this project needs to use"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created resources"
  default     = {}
}
