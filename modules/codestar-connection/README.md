# CodeStar Connection

Initiates a [CodeStar connection] to allow merged GitHub pull requests to
trigger your [CI/CD pipeline]. The connection will be created as "Pending."
After applying this module, you will need to visit the "Settings" section of the
Developer Tools Console in the AWS Management Console to install the GitHub
application in your organization or account.

[CodeStar connection]: https://docs.aws.amazon.com/dtconsole/latest/userguide/welcome-connections.html
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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codestarconnections_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection) | resource |
| [aws_ssm_parameter.codestar_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name for this CodeStar connection | `string` | n/a | yes |
| <a name="input_provider_type"></a> [provider\_type](#input\_provider\_type) | Provider, such as GitHub | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the created CodeStar connection |
| <a name="output_parameter"></a> [parameter](#output\_parameter) | SSM parameter containing the ARN of the CodeStar connection |
<!-- END_TF_DOCS -->
