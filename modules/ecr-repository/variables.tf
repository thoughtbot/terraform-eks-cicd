variable "name" {
  type        = string
  description = "Name for this ECR repository"
}

variable "namespace" {
  type        = list(string)
  description = "Prefix to apply to created resources"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created resources"
  default     = {}
}

variable "workload_account_ids" {
  type        = list(string)
  description = "AWS account IDs which are allowed to pull this image"
  default     = []
}
