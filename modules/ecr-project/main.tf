module "project" {
  source = "../codebuild-project"

  artifacts_bucket      = var.artifacts_bucket
  buildspec             = var.buildspec
  codestar_connection   = var.codestar_connection
  enable_github_webhook = var.enable_github_webhook
  github_repository     = var.github_repository
  name                  = var.name
  namespace             = var.namespace
  policies              = merge(var.policies, { ecr = aws_iam_policy.ecr })
  privileged_mode       = true
  tags                  = var.tags

  environment_variables = {
    ECR_REPOSITORY_NAME = data.aws_ecr_repository.this.name
  }
}

resource "aws_iam_policy" "ecr" {
  name   = join("-", concat(var.namespace, [var.name, "ecr"]))
  policy = data.aws_iam_policy_document.ecr.json
}

data "aws_iam_policy_document" "ecr" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:ListImages"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = concat(
      [data.aws_ecr_repository.this.arn],
      values(data.aws_ecr_repository.secondary).*.arn
    )
  }
}

data "aws_ecr_repository" "this" {
  name = var.ecr_repository
}

data "aws_ecr_repository" "secondary" {
  for_each = toset(var.secondary_ecr_repositories)

  name = each.value
}
