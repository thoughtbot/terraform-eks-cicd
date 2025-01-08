# Terraform EKS CI/CD Pipeline

This repository contains Terraform modules for building a CI/CD pipeline for
applications running on [EKS].

Major features:

* Deploy to EKS clusters across accounts and regions
* Use [CodeBuild] to build Docker images and generate Kubernetes manifests
* Use [CodePipeline] to build and deploy a containerized application
* Generate your manifests from vanilla YAML, [Kustomize], or [Helm]
* Apply generated manifests to the cluster whenever the application or manifests
  are updated
* Easily create jobs or other tasks when deploying

These modules assume that you have separate Git repositories for application
source code and Kubernetes manifests.

## Modules

The modules provide the major building blocks:

### Setup

* [ecr-repository](./modules/ecr-repository): Create ECR repositories for your
  pipelines
* [artifact-bucket](./modules/artifact-bucket): Create artifact buckets for your
  pipelines
* [codebuild-credential](./modules/codebuild-credential): Connect CodeBuild to GitHub to
  build Docker images and verify manifest generation whenever pull requests are
  opened
* [codestar-connection](./modules/codestar-connection): Connect CodePipeline to GitHub
  to run your pipelines whenever pull requests are merged
* [deploy-role](./modules/deploy-role): Create a deployment IAM role with
  permission to connect to a Kubernetes cluster usable by CodeBuild

### Continuous Integration

* [ecr-project](./modules/ecr-project): Create a CodeBuild project to build and push
  Docker images whenever pull requests are opened or merged
* [manifests-project](./modules/manifests-project): Create a CodeBuild project to
  regenerate manifests whenever the application code or application manifests
  are updated

### Continuous Deployment

* [deploy-project](./modules/deploy-project): Create a CodeBuild project to apply
  generated manifests to the cluster
* [cicd-pipeline](./modules/cicd-pipeline): Create a CodePipeline which ties together
  the CodeBuild projects in a pipeline, building Docker images, generating
  updated manifests, and applying them to the cluster

[EKS]: https://aws.amazon.com/eks/
[CodeBuild]: https://aws.amazon.com/codebuild/
[CodePipeline]: https://aws.amazon.com/codepipeline/
[Kustomize]: https://kustomize.io/
[Helm]: https://helm.sh/

## Contributing

Please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

These modules are Copyright © 2021 Joe Ferris and thoughtbot. It is free
software, and may be redistributed under the terms specified in the [LICENSE]
file.

[LICENSE]: ./LICENSE

<!-- START /templates/footer.md -->
<!-- END /templates/footer.md -->

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->