# Deploy Project

Creates a CodeBuild project capable of applying generated manifests to a
cluster.

To use this module, you will need a [manifests project] which produces compiled
Kubernetes manifest as a CodeBuild artifact. You can then apply this module and
supply a [buildspec] which applies the manifests to your cluster as required.

[manifests project]: ../manifests-project
[buildspec]: https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html

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
| [aws_iam_role.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifacts_bucket"></a> [artifacts\_bucket](#input\_artifacts\_bucket) | Name of the S3 bucket in which artifacts are stored | `string` | n/a | yes |
| <a name="input_buildspec"></a> [buildspec](#input\_buildspec) | Override the buildspec for this project | `string` | `null` | no |
| <a name="input_cluster_names"></a> [cluster\_names](#input\_cluster\_names) | Clusters to which this project is allowed to deploy | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for this CodeBuild project | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Prefix to apply to created resources | `list(string)` | `[]` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Additional policies for this CodeBuild project's role | `map(object({ arn = string }))` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to created resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
