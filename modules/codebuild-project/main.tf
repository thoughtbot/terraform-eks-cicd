locals {
  name = join("-", distinct(concat(var.namespace, [var.name])))
}

resource "aws_codebuild_project" "this" {
  name          = local.name
  build_timeout = "20"
  service_role  = aws_iam_role.codebuild.arn
  tags          = var.tags

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    privileged_mode = var.privileged_mode
    type            = "LINUX_CONTAINER"

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.this.account_id
    }

    dynamic "environment_variable" {
      for_each = var.environment_variables

      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  source {
    buildspec = var.buildspec
    location  = "https://github.com/${var.github_repository}.git"
    type      = "GITHUB"
  }

  dynamic "secondary_sources" {
    for_each = var.secondary_github_repositories

    content {
      location          = "https://github.com/${secondary_sources.value}.git"
      source_identifier = "source"
      type              = "GITHUB"
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = local.name
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
    sid = "UseCodeStarConnection"
    actions = [
      "codestar-connections:UseConnection"
    ]
    resources = [
      data.aws_codestarconnections_connection.this.arn
    ]
  }
}

data "aws_caller_identity" "this" {}

data "aws_codestarconnections_connection" "this" {
  arn = data.aws_ssm_parameter.codestar_connection.value
}

data "aws_ssm_parameter" "codestar_connection" {
  name = var.codestar_connection
}
