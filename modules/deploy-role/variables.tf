variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "deployment_account_ids" {
  type        = list(string)
  description = "IDs of AWS accounts running continuous deployment"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to created AWS resources"
  default     = {}
}
