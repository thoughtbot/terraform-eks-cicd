variable "aws_tags" {
  type        = map(string)
  description = "Tags to be applied to created AWS resources"
  default     = {}
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "deployment_account_id" {
  type        = string
  description = "ID of the AWS account containing CodeBuild projects"
}
