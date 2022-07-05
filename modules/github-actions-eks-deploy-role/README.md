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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_github_pull_requests"></a> [allow\_github\_pull\_requests](#input\_allow\_github\_pull\_requests) | Set to true to enable running from pull requests | `bool` | `false` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | The branch allowed to assume this IAM role | `string` | n/a | yes |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | Name of the GitHub organization which will assume this role | `string` | n/a | yes |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Name of the GitHub repository which will assume this role | `string` | n/a | yes |
| <a name="input_iam_oidc_provider_arn"></a> [iam\_oidc\_provider\_arn](#input\_iam\_oidc\_provider\_arn) | ARN of the IAM OIDC provider for GitHub | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the IAM role | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to created AWS resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the created IAM role |
<!-- END_TF_DOCS -->
