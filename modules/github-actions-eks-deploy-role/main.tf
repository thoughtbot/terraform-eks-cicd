resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = var.name
  tags               = merge(var.tags, local.cluster_tags)
}

resource "aws_iam_role_policy" "permissions" {
  name   = var.name
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
    effect    = "Allow"
    actions   = ["eks:DescribeCluster"]
    resources = ["*"]
  }

  statement {
    sid       = "AllowECRAuth"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid = "AllowPull"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
    resources = ["*"]
  }
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

  cluster_tags = zipmap(
    [for cluster in var.cluster_names : "cluster.${cluster}.deploy"],
    [for cluster in var.cluster_names : "true"]
  )
}
