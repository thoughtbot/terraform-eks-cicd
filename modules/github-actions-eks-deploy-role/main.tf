resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = local.role_name
  # TODO: tags
  tags               = merge(var.tags, local.tags)
}

resource "aws_iam_role_policy" "eks" {
  name   = local.role_name
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.eks.json
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

data "aws_iam_policy_document" "eks" {
  # if multi-account
  statement {
    sid       = "AssumeDeployRoles"
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:ResourceTag/deployTo"
      values   = var.cluster_names
    }
  }

  # if EKS in same account
  statement {
    effect    = "Allow"
    actions   = ["eks:DescribeCluster"]
    resources = [data.aws_eks_cluster.this.arn]
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

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

locals {
  role_name = coalesce(var.eks_deploy_role_name, "${var.cluster_name}-deploy")

  # TODO: need deployTo?
  tags = {
    deployTo = var.cluster_name
  }
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
