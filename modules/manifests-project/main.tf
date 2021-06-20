module "project" {
  source = "../codebuild-project"

  artifacts_bucket    = var.artifacts_bucket
  buildspec           = var.buildspec
  codestar_connection = var.codestar_connection
  github_repository   = var.manifests_repository
  name                = var.name
  namespace           = var.namespace
  policies            = var.policies
  privileged_mode     = false
  tags                = var.tags

  environment_variables = {
    ECR_REPOSITORY_NAME = data.aws_ecr_repository.this.name
  }

  secondary_github_repositories = [
    var.source_repository
  ]
}

data "aws_ecr_repository" "this" {
  name = var.ecr_repository
}
