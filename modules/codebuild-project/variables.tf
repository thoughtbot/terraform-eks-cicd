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

variable "environment_variables" {
  description = "Environment variables to set during the build"
  type        = map(string)
  default     = {}
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

variable "privileged_mode" {
  description = "Set to true to run in privileged mode (required for Docker)"
  type        = bool
  default     = false
}

variable "secondary_github_repositories" {
  type        = list(string)
  description = "Full name of the GitHub repository at which secondary source is found"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created resources"
  default     = {}
}
