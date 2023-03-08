# Deploy Role

Creates an AWS IAM role which trusts the deployment account.

This role should be added to the cluster's aws-auth ConfigMap to allow
deployment. CodeBuild projects in the deployment account can assume this role to
deploy to the cluster.

Setting up:

* Create an instance of this module for each EKS cluster, in the same account as
  the cluster.
* Add the role's ARN to the [aws-auth ConfigMap].
* Make sure the EKS cluster is included in the cluster names for your [deploy
  project]. This will ensure the CodeBuild IAM role has permission to assume the
  deploy role.
* Provide the role's ARN in the corresponding deployment in your [pipeline].

Once configured correctly, this will allow the deploy CodeBuild projects to
apply the generated manifests to the appropriate cluster. AWS tags are used to
ensure that each CodeBuild role can only connect to the appropriate cluster.

[aws-auth ConfigMap]: https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
[deploy project]: ../deploy-project
[pipeline]: ../cicd-pipeline

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

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
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_deployment_account_ids"></a> [deployment\_account\_ids](#input\_deployment\_account\_ids) | IDs of AWS accounts running continuous deployment | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to created AWS resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the created IAM role |
<!-- END_TF_DOCS -->
