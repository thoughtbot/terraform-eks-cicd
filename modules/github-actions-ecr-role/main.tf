resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = var.name
}

resource "aws_iam_role_policy" "permissions" {
  name   = "ecr"
  policy = data.aws_iam_policy_document.permissions.json
  role   = aws_iam_role.this.id
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        for target in local.repository_targets :
        "repo:${var.github_organization}/${var.github_repository}:${target}"
      ]
    }
    principals {
      identifiers = [var.iam_oidc_provider_arn]
      type        = "Federated"
    }
  }
}

data "aws_iam_policy_document" "permissions" {
  statement {
    sid       = "AllowECRAuth"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid = "AllowPushPull"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]
    resources = values(data.aws_ecr_repository.this).*.arn
  }
}

data "aws_ecr_repository" "this" {
  for_each = toset(var.ecr_repositories)

  name = each.value
}

locals {
  repository_targets = concat(
    [
      for branch in var.github_branches :
      "ref:refs/heads/${branch}"
    ],
    (
      var.allow_github_pull_requests ?
      ["pull_request"] :
      []
    )
  )
}
