# Manifests Project

This modules will create a CodeBuild project for generating updated Kubernetes
manifests when either the application source or manifest source are updated.

To use this module:

* Add a [buildspec] to your manifests repository that generates Kubernetes
  manifests using Kustomize or Helm.
* Make sure to write your manfiests as an artifact in the build.
* Apply this module to create the CodeBuild project using the buildspec.
* Add your project to your [CI/CD pipeline] to apply updated manifests whenever
  pull requests are merged.

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
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifacts_bucket"></a> [artifacts\_bucket](#input\_artifacts\_bucket) | Name of the S3 bucket in which artifacts are stored | `string` | n/a | yes |
| <a name="input_buildspec"></a> [buildspec](#input\_buildspec) | Override the buildspec for this project | `string` | `null` | no |
| <a name="input_codestar_connection"></a> [codestar\_connection](#input\_codestar\_connection) | SSM parameter containing the ARN of the CodeStar connection | `string` | n/a | yes |
| <a name="input_ecr_repository"></a> [ecr\_repository](#input\_ecr\_repository) | ECR repository from which images should be pulled | `string` | n/a | yes |
| <a name="input_manifests_repository"></a> [manifests\_repository](#input\_manifests\_repository) | Full name of the GitHub repository in which manifests are found | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for this CodeBuild project | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Prefix to apply to created resources | `list(string)` | `[]` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Additional policies for this CodeBuild project's role | `map(object({ arn = string }))` | `{}` | no |
| <a name="input_source_repository"></a> [source\_repository](#input\_source\_repository) | Full name of the GitHub repository in which source is found | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | The created project |
| <a name="output_name"></a> [name](#output\_name) | Name of the created project |
<!-- END_TF_DOCS -->
