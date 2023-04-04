variable "artifacts_bucket" {
  description = "Name of the S3 bucket in which artifacts are stored"
  type        = string
}

variable "codestar_connection" {
  type        = string
  description = "SSM parameter containing the ARN of the CodeStar connection"
}

variable "deploy_project" {
  description = "Name of the CodeBuild project for deploying"
  type        = string
}

variable "deployments" {
  description = "Deployments managed by this pipeline"
  type = map(object({
    cluster_name  = string
    region        = string
    role_arn      = string
    manifest_path = string
  }))
}

variable "ecr_project" {
  description = "Name of the CodeBuild project for building ECR images"
  type        = string
}

variable "deploy_env_vars" {
  description = "Environment variables to be set during deploy"
  type        = map(string)
  default     = {}
}

variable "kms_key" {
  description = "KMS key for encrypting data in this pipeline"
  type        = object({ arn = string })
  default     = null
}

variable "manifests_project" {
  description = "Name of the CodeBuild project for building ECR images"
  type        = string
}

variable "manifests_repository_branch" {
  description = "Name of the branch on which manifests are found"
  type        = string
  default     = "main"
}

variable "manifests_repository_name" {
  description = "Name of the GitHub repository containing manifests"
  type        = string
}

variable "name" {
  type        = string
  description = "Name for the CI/CD pipeline"
}

variable "namespace" {
  type        = list(string)
  description = "Prefix to apply to created resources"
  default     = []
}

variable "source_repository_branch" {
  default     = "main"
  description = "Name of the branch on which source is found"
  type        = string
}

variable "source_repository_name" {
  description = "Name of the GitHub repository containing source code"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created resources"
  default     = {}
}
