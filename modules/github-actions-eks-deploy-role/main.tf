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

  dynamic "statement" {
    for_each = length(var.managed_prometheus_workspace_ids) == 0 ? [] : [true]

    content {
      sid = "AllowManageAMPRules"
      actions = [
        "aps:CreateRuleGroupsNamespace",
        "aps:DescribeRuleGroupsNamespace",
        "aps:PutRuleGroupsNamespace",
        "aps:DeleteRuleGroupsNamespace",
      ]
      resources = [
        for workspace_id in var.managed_prometheus_workspace_ids :
        join(":", [
          "arn",
          data.aws_partition.this.partition,
          "aps",
          data.aws_region.this.name,
          data.aws_caller_identity.this.account_id,
          "rulegroupsnamespace/${workspace_id}/${local.amp_prefix}*"
        ])
      ]
    }
  }

  dynamic "statement" {
    for_each = length(var.managed_prometheus_workspace_ids) == 0 ? [] : [true]
    content {
      sid = "AllowListAMPRules"
      actions = [
        "aps:ListRuleGroupsNamespaces",
      ]
      resources = [
        for workspace_id in var.managed_prometheus_workspace_ids :
        join(":", [
          "arn",
          data.aws_partition.this.partition,
          "aps",
          data.aws_region.this.name,
          data.aws_caller_identity.this.account_id,
          "workspace/${workspace_id}"
        ])
      ]
    }
  }

  dynamic "statement" {
    for_each = length(var.managed_prometheus_workspace_ids) == 0 ? [] : [true]
    content {
      sid       = "AllowListAMPWorkspaces"
      actions   = ["aps:ListWorkspaces"]
      resources = ["*"]
    }
  }
}

data "aws_caller_identity" "this" {}

data "aws_region" "this" {}

data "aws_partition" "this" {}

locals {
  amp_prefix = coalesce(
    var.managed_prometheus_namespace_prefix,
    "${var.github_repository}-"
  )
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
