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
  description = "ECR repository from which images should be pulled"
}

variable "manifests_repository" {
  type        = string
  description = "Full name of the GitHub repository in which manifests are found"
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

variable "source_repository" {
  type        = string
  description = "Full name of the GitHub repository in which source is found"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created resources"
  default     = {}
}
