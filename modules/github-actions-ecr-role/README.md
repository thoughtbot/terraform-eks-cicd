# GitHub Actions ECR Role

Provisions an IAM role for a GitHub workflow with permissions to push to ECR.

Usage:

``` terraform
module "role" {
  source = "github.com/thoughtbot/terraform-eks-cicd//modules/github-actions-ecr-role?ref=main"

  # You must have an existing IAM OIDC provider for GitHub Actions.
  # https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
  iam_oidc_provider_arn      = "ARN"

  # If you want to push container images for pull requests, set this to true
  allow_github_pull_requests = true

  ecr_repositories           = ["example"]
  github_branches            = ["main", "production"]
  github_organization        = "thoughtbot"
  github_repository          = "example"
  name                       = "github-actions-example-ecr"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
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
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_github_pull_requests"></a> [allow\_github\_pull\_requests](#input\_allow\_github\_pull\_requests) | Set to true to enable running from pull requests | `bool` | `false` | no |
| <a name="input_ecr_repositories"></a> [ecr\_repositories](#input\_ecr\_repositories) | Name of the ECR repositories to which permissions should be granted | `list(string)` | n/a | yes |
| <a name="input_github_branches"></a> [github\_branches](#input\_github\_branches) | Branches allowed to push to this repository | `list(string)` | n/a | yes |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | Name of the GitHub organization which will assume this role | `string` | n/a | yes |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Name of the GitHub repository which will assume this role | `string` | n/a | yes |
| <a name="input_iam_oidc_provider_arn"></a> [iam\_oidc\_provider\_arn](#input\_iam\_oidc\_provider\_arn) | ARN of the IAM OIDC provider for GitHub | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the IAM role | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the created IAM role |
<!-- END_TF_DOCS -->
