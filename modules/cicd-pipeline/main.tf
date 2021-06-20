resource "aws_codepipeline" "this" {
  name     = join("-", concat(var.namespace, [var.name]))
  role_arn = aws_iam_role.pipeline.arn
  tags     = var.tags

  artifact_store {
    location = data.aws_s3_bucket.artifacts.bucket
    type     = "S3"

    dynamic "encryption_key" {
      for_each = var.kms_key == null ? [] : [true]

      content {
        id   = var.kms_key.arn
        type = "KMS"
      }
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source"]

      configuration = {
        BranchName           = var.source_repository_branch
        ConnectionArn        = data.aws_codestarconnections_connection.this.arn
        FullRepositoryId     = var.source_repository_name
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }

    action {
      name             = "Manifests"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["manifests"]

      configuration = {
        ConnectionArn        = data.aws_codestarconnections_connection.this.arn
        FullRepositoryId     = var.manifests_repository_name
        BranchName           = var.manifests_repository_branch
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Docker"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source"]
      output_artifacts = []
      version          = "1"

      configuration = {
        ProjectName = local.ecr_project.name
      }
    }

    action {
      name             = "Manifests"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["manifests", "source"]
      output_artifacts = ["compiled_manifests"]
      version          = "1"

      configuration = {
        PrimarySource = "manifests"
        ProjectName   = local.manifests_project.name
      }
    }
  }

  stage {
    name = "Deploy"

    dynamic "action" {
      for_each = var.deployments

      content {
        name             = action.key
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["compiled_manifests"]
        output_artifacts = []
        version          = "1"

        configuration = {
          ProjectName = local.deploy_project.name

          EnvironmentVariables = jsonencode([
            { name = "DEPLOY_ROLE_ARN", value = action.value.role_arn },
            { name = "EKS_CLUSTER_NAME", value = action.value.cluster_name },
            { name = "EKS_CLUSTER_REGION", value = action.value.region },
            { name = "MANIFEST_PATH", value = action.value.manifest_path }
          ])
        }
      }
    }
  }
}

resource "aws_iam_role" "pipeline" {
  assume_role_policy = data.aws_iam_policy_document.pipeline_assume_role.json
  name               = join("-", concat(var.namespace, [var.name, "pipeline"]))
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "pipeline" {
  policy_arn = aws_iam_policy.pipeline.arn
  role       = aws_iam_role.pipeline.name
}

resource "aws_iam_policy" "pipeline" {
  name   = join("-", concat(var.namespace, [var.name, "pipeline"]))
  policy = data.aws_iam_policy_document.pipeline.json
  tags   = var.tags
}

data "aws_iam_policy_document" "pipeline_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "pipeline" {
  statement {
    sid = "UseArtifactsBucket"
    actions = [
      "s3:CopyObject*",
      "s3:DeleteObject*",
      "s3:Get*",
      "s3:List*",
      "s3:Put*"
    ]
    resources = [
      data.aws_s3_bucket.artifacts.arn,
      "${data.aws_s3_bucket.artifacts.arn}/*",
    ]
  }

  dynamic "statement" {
    for_each = var.kms_key == null ? [] : [true]

    content {
      sid = "DecryptBucket"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ]
      resources = [var.kms_key.arn]
    }
  }

  statement {
    sid = "StartCodeBuild"
    actions = [
      "codebuild:BatchGetBuildBatches",
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:StartBuildBatch"
    ]
    resources = [
      local.deploy_project.arn,
      local.ecr_project.arn,
      local.manifests_project.arn
    ]
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

data "aws_codestarconnections_connection" "this" {
  arn = data.aws_ssm_parameter.codestar_connection.value
}

data "aws_s3_bucket" "artifacts" {
  bucket = var.artifacts_bucket
}

data "aws_ssm_parameter" "codestar_connection" {
  name = var.codestar_connection
}

data "aws_caller_identity" "this" {}

data "aws_region" "this" {}

locals {
  deploy_project = {
    arn = join(":", [
      "arn",
      "aws",
      "codebuild",
      data.aws_region.this.name,
      data.aws_caller_identity.this.account_id,
      "project/${var.deploy_project}"
    ])
    name = var.deploy_project
  }
  ecr_project = {
    arn = join(":", [
      "arn",
      "aws",
      "codebuild",
      data.aws_region.this.name,
      data.aws_caller_identity.this.account_id,
      "project/${var.ecr_project}"
    ])
    name = var.ecr_project
  }
  manifests_project = {
    arn = join(":", [
      "arn",
      "aws",
      "codebuild",
      data.aws_region.this.name,
      data.aws_caller_identity.this.account_id,
      "project/${var.manifests_project}"
    ])
    name = var.manifests_project
  }
}
