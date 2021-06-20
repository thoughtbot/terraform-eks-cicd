resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "${var.cluster_name}-deploy"
  tags               = merge(var.aws_tags, local.aws_tags)
}

resource "aws_iam_role_policy" "eks" {
  name   = "${var.cluster_name}-deploy"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.eks.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.deployment_account_id}:root"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalTag/cluster.${var.cluster_name}.deploy"
      values   = ["true"]
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
  aws_tags = {
    deployTo = var.cluster_name
  }
}
