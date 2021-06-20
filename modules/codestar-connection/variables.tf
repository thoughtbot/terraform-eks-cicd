variable "name" {
  type        = string
  description = "Name for this CodeStar connection"
}

variable "provider_type" {
  type        = string
  description = "Provider, such as GitHub"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to created resources"
  default     = {}
}
