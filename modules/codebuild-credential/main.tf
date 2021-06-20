resource "aws_codebuild_source_credential" "this" {
  auth_type   = local.auth_types[var.provider_type]
  server_type = local.server_types[var.provider_type]
  token       = data.aws_ssm_parameter.token.value
  user_name   = var.username
}

data "aws_ssm_parameter" "token" {
  name = var.token_parameter
}

locals {
  auth_types = {
    BitBucket = "BASIC_AUTH"
    GitHub    = "PERSONAL_ACCESS_TOKEN"
  }

  server_types = {
    BitBucket = "BITBUCKET"
    GitHub    = "GITHUB"
  }
}
