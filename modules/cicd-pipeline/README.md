# CI/CD Pipeline

Ties together an [ECR project], a [manifests project], and a [deploy project] in
a pipeline for continuous integration and deployment.

[ECR project]: ../ecr-project
[manifests project]: ../manifests-project
[deploy project]: ../deploy-project

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_codestarconnections_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/codestarconnections_connection) | data source |
| [aws_iam_policy_document.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_s3_bucket.artifacts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_ssm_parameter.codestar_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifacts_bucket"></a> [artifacts\_bucket](#input\_artifacts\_bucket) | Name of the S3 bucket in which artifacts are stored | `string` | n/a | yes |
| <a name="input_codestar_connection"></a> [codestar\_connection](#input\_codestar\_connection) | SSM parameter containing the ARN of the CodeStar connection | `string` | n/a | yes |
| <a name="input_deploy_project"></a> [deploy\_project](#input\_deploy\_project) | Name of the CodeBuild project for deploying | `string` | n/a | yes |
| <a name="input_deployments"></a> [deployments](#input\_deployments) | Deployments managed by this pipeline | <pre>map(object({<br>    cluster_name  = string<br>    region        = string<br>    role_arn      = string<br>    manifest_path = string<br>  }))</pre> | n/a | yes |
| <a name="input_ecr_project"></a> [ecr\_project](#input\_ecr\_project) | Name of the CodeBuild project for building ECR images | `string` | n/a | yes |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | KMS key for encrypting data in this pipeline | `object({ arn = string })` | `null` | no |
| <a name="input_manifests_project"></a> [manifests\_project](#input\_manifests\_project) | Name of the CodeBuild project for building ECR images | `string` | n/a | yes |
| <a name="input_manifests_repository_branch"></a> [manifests\_repository\_branch](#input\_manifests\_repository\_branch) | Name of the branch on which manifests are found | `string` | `"main"` | no |
| <a name="input_manifests_repository_name"></a> [manifests\_repository\_name](#input\_manifests\_repository\_name) | Name of the GitHub repository containing manifests | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for the CI/CD pipeline | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Prefix to apply to created resources | `list(string)` | `[]` | no |
| <a name="input_source_repository_branch"></a> [source\_repository\_branch](#input\_source\_repository\_branch) | Name of the branch on which source is found | `string` | `"main"` | no |
| <a name="input_source_repository_name"></a> [source\_repository\_name](#input\_source\_repository\_name) | Name of the GitHub repository containing source code | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to created resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
