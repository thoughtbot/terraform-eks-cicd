# ECR Project

This modules creates a CodeBuild project to build Docker images from your
application code.

To use this module:

* Create an ECR repository for your Docker images.
* Add a Dockerfile and [buildspec] to your application source repository.
* The buildspec should include instructions for building and pushing your Docker
  images to your ECR repository.
* The CodeBuild project will use a role with permission to pull from and push to
  your ECR repository.
* Add your ECR project to your [CI/CD pipeline] to build images when pull
  requests are merged.

[buildspec]: https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html
[CI/CD pipeline]: ../cicd-pipeline

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_project"></a> [project](#module\_project) | ../codebuild-project |  |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_ecr_repository.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_iam_policy_document.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifacts_bucket"></a> [artifacts\_bucket](#input\_artifacts\_bucket) | Name of the S3 bucket in which artifacts are stored | `string` | n/a | yes |
| <a name="input_buildspec"></a> [buildspec](#input\_buildspec) | Override the buildspec for this project | `string` | `null` | no |
| <a name="input_codestar_connection"></a> [codestar\_connection](#input\_codestar\_connection) | SSM parameter containing the ARN of the CodeStar connection | `string` | n/a | yes |
| <a name="input_ecr_repository"></a> [ecr\_repository](#input\_ecr\_repository) | ECR repository to which images should be pushed | `string` | n/a | yes |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Full name of the GitHub repository at which source is found | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for this CodeBuild project | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Prefix to apply to created resources | `list(string)` | `[]` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Additional policies for this CodeBuild project's role | `map(object({ arn = string }))` | `{}` | no |
| <a name="input_secondary_ecr_repositories"></a> [secondary\_ecr\_repositories](#input\_secondary\_ecr\_repositories) | Additional ECR repositories this project needs to use | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | The created project |
| <a name="output_name"></a> [name](#output\_name) | Name of the created project |
<!-- END_TF_DOCS -->
