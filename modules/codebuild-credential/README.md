# CodeBuild Credential

Creates a CodeBuild credential for connecting AWS CodeBuild to GitHub.

This is only necessary if you want to run the CodeBuild projects for ECR images
and manifest generation when pull requests are opened. It's necessary because
CodeBuild projects can't currently use a CodeStar connection outside of
CodePipeline, and CodePipeline doesn't support running for pull requests.

If you want to run your projects for pull requests, you can either:

* Create a personal OAuth token for your GitHub account (a bot user is
  recommended for this) and use this module to plug it in
* Manually connect CodeBuild to GitHub through the AWS Management Console

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
| [aws_codebuild_source_credential.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_source_credential) | resource |
| [aws_ssm_parameter.token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_provider_type"></a> [provider\_type](#input\_provider\_type) | Provider (GitHub, Bitbucket) | `string` | n/a | yes |
| <a name="input_token_parameter"></a> [token\_parameter](#input\_token\_parameter) | SSM parameter containing the OAuth token or password | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username for BitBucket | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the created credential |
<!-- END_TF_DOCS -->
