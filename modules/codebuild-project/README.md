# CodeBuild Project

This contains some common boilerplate for CodeBuild projects used by the other
CI modules:

* [ecr-project](../ecr-project)
* [manifests-project](../manifests-project)

You won't need to use this module directly unless you're doing something
special.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_webhook.project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook) | resource |
| [aws_iam_role.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_codestarconnections_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codestarconnections_connection) | data source |
| [aws_iam_policy_document.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.codestar_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifacts_bucket"></a> [artifacts\_bucket](#input\_artifacts\_bucket) | Name of the S3 bucket in which artifacts are stored | `string` | n/a | yes |
| <a name="input_buildspec"></a> [buildspec](#input\_buildspec) | Override the buildspec for this project | `string` | `null` | no |
| <a name="input_codestar_connection"></a> [codestar\_connection](#input\_codestar\_connection) | SSM parameter containing the ARN of the CodeStar connection | `string` | n/a | yes |
| <a name="input_enable_github_webhook"></a> [enable\_github\_webhook](#input\_enable\_github\_webhook) | Set to false if the GitHub token can't manage webhooks | `bool` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables to set during the build | `map(string)` | `{}` | no |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Full name of the GitHub repository at which source is found | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for this CodeBuild project | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Prefix to apply to created resources | `list(string)` | `[]` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Additional policies for this CodeBuild project's role | `map(object({ arn = string }))` | `{}` | no |
| <a name="input_privileged_mode"></a> [privileged\_mode](#input\_privileged\_mode) | Set to true to run in privileged mode (required for Docker) | `bool` | `false` | no |
| <a name="input_secondary_github_repositories"></a> [secondary\_github\_repositories](#input\_secondary\_github\_repositories) | Full name of the GitHub repository at which secondary source is found | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | The created project |
| <a name="output_name"></a> [name](#output\_name) | Name of the created project |
<!-- END_TF_DOCS -->
