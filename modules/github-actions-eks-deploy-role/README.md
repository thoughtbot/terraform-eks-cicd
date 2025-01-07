# GitHub Actions EKS Deploy Role

Provisions an IAM role for a GitHub workflow with permissions to deploy to EKS.

Usage:

``` terraform
module "role" {
  source = "github.com/thoughtbot/terraform-eks-cicd//modules/github-actions-eks-deploy-role?ref=main"

  # You must have an existing IAM OIDC provider for GitHub Actions.
  # https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
  iam_oidc_provider_arn      = "ARN"

  cluster_name               = "cluster-name"

  github_branches            = ["main"]
  github_organization        = "thoughtbot"
  github_repository          = "example"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_github_pull_requests"></a> [allow\_github\_pull\_requests](#input\_allow\_github\_pull\_requests) | Set to true to enable running from pull requests | `bool` | `false` | no |
| <a name="input_cluster_names"></a> [cluster\_names](#input\_cluster\_names) | Names of the EKS clusters to which this role can deploy | `list(string)` | n/a | yes |
| <a name="input_github_branches"></a> [github\_branches](#input\_github\_branches) | Branches allowed to push to this repository | `list(string)` | n/a | yes |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | Name of the GitHub organization which will assume this role | `string` | n/a | yes |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Name of the GitHub repository which will assume this role | `string` | n/a | yes |
| <a name="input_iam_oidc_provider_arn"></a> [iam\_oidc\_provider\_arn](#input\_iam\_oidc\_provider\_arn) | ARN of the IAM OIDC provider for GitHub | `string` | n/a | yes |
| <a name="input_managed_prometheus_namespace_prefix"></a> [managed\_prometheus\_namespace\_prefix](#input\_managed\_prometheus\_namespace\_prefix) | Allowed prefix for AMP rules; defaults to GitHub repository | `string` | `null` | no |
| <a name="input_managed_prometheus_workspace_ids"></a> [managed\_prometheus\_workspace\_ids](#input\_managed\_prometheus\_workspace\_ids) | Allowed AMP workspace; disabled if empty | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the IAM role | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to created AWS resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the created IAM role |
| <a name="output_name"></a> [name](#output\_name) | Name of the created IAM role |
<!-- END_TF_DOCS -->
