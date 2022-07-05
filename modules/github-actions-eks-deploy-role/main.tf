resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "${var.cluster_name}-deploy"
  tags               = merge(var.tags, local.tags)
}

resource "aws_iam_role_policy" "eks" {
  name   = "${var.cluster_name}-deploy"
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
  statement {
    effect    = "Allow"
    actions   = ["eks:DescribeCluster"]
    resources = [data.aws_eks_cluster.this.arn]
  }
}

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

locals {
  tags = {
    deployTo = var.cluster_name
  }
  repository_targets = concat(
    [
      for branch in var.github_branches :
      "ref:refs/heads/${branch}"
    ]
  )
}
