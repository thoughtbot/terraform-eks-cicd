variable "artifacts_bucket" {
  description = "Name of the S3 bucket in which artifacts are stored"
  type        = string
}

variable "buildspec" {
  description = "Override the buildspec for this project"
  type        = string
  default     = null
}

variable "cluster_names" {
  description = "Clusters to which this project is allowed to deploy"
  type        = list(string)
  default     = []
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

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created resources"
  default     = {}
}
