resource "aws_ecr_repository" "this" {
  name                 = join("/", concat(var.namespace, [var.name]))
  image_tag_mutability = "IMMUTABLE"
  tags                 = var.tags
}

resource "aws_ecr_repository" "base_mirror" {
  name                 = join("/", concat(var.namespace, ["${var.name}-base"]))
  image_tag_mutability = "IMMUTABLE"
  tags                 = var.tags
}

resource "aws_ecr_repository_policy" "pull" {
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.pull.json
}

data "aws_iam_policy_document" "pull" {
  statement {
    principals {
      type        = "AWS"
      identifiers = local.account_arns
    }
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability"
    ]
  }
}

data "aws_caller_identity" "this" {}

locals {
  account_ids = toset(concat(
    [data.aws_caller_identity.this.account_id],
    var.workload_account_ids
  ))

  account_arns = [
    for account_id in local.account_ids :
    "arn:aws:iam::${account_id}:root"
  ]
}
