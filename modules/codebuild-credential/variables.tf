variable "provider_type" {
  type        = string
  description = "Provider (GitHub, Bitbucket)"

  validation {
    condition     = can(regex("^GitHub|Bitbucket$", var.provider_type))
    error_message = "Must be one of GitHub or Bitbucket."
  }
}

variable "token_parameter" {
  type        = string
  description = "SSM parameter containing the OAuth token or password"
}

variable "username" {
  type        = string
  description = "Username for BitBucket"
  default     = null
}
