resource "aws_codebuild_project" "this" {
  name          = local.name
  build_timeout = "20"
  service_role  = aws_iam_role.codebuild.arn
  tags          = var.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    privileged_mode = false
    type            = "LINUX_CONTAINER"
  }

  source {
    buildspec = var.buildspec
    type      = "CODEPIPELINE"
  }
}

resource "aws_iam_role" "codebuild" {
  name               = local.name
  tags               = merge(var.tags, local.cluster_tags)
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.policies

  policy_arn = each.value.arn
  role       = aws_iam_role.codebuild.name
}

data "aws_iam_policy_document" "codebuild_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "codebuild" {
  name   = local.name
  role   = aws_iam_role.codebuild.id
  policy = data.aws_iam_policy_document.codebuild.json
}

data "aws_iam_policy_document" "codebuild" {
  statement {
    sid = "WriteLogs"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    sid = "ListArtifacts"
    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::${var.artifacts_bucket}"]
  }

  statement {
    sid = "ReadWriteArtifacts"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = ["arn:aws:s3:::${var.artifacts_bucket}/*"]
  }

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
}

locals {
  cluster_tags = zipmap(
    [for cluster in var.cluster_names : "cluster.${cluster}.deploy"],
    [for cluster in var.cluster_names : "true"]
  )

  name = join("-", distinct(concat(var.namespace, [var.name])))
}
