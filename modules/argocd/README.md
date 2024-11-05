# ArgoCD Deployment

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.8.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.70.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.15.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >=2.32.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.70.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.15.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >=2.32.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_iam_policy_argocd_policy"></a> [aws\_iam\_policy\_argocd\_policy](#module\_aws\_iam\_policy\_argocd\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 5.46.0 |
| <a name="module_aws_iam_role_argocd"></a> [aws\_iam\_role\_argocd](#module\_aws\_iam\_role\_argocd) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | 5.46.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.argocd_service_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.argo_app_project](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.argocd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.argo_dex_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.argo_notifications_ms_teams](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [aws_secretsmanager_secret.argo_notifications_ms_teams_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.github_app_sso_config_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.argo_notifications_ms_teams_secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.github_app_sso_config_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_albc_helm_release_metadata"></a> [albc\_helm\_release\_metadata](#input\_albc\_helm\_release\_metadata) | The metadata for the AWS Load Balancer Controller Helm release | `any` | `{}` | no |
| <a name="input_applicationset_replicas"></a> [applicationset\_replicas](#input\_applicationset\_replicas) | The number of ArgoCD application set replicas | `number` | `2` | no |
| <a name="input_argo_github_app_sso_secret_name"></a> [argo\_github\_app\_sso\_secret\_name](#input\_argo\_github\_app\_sso\_secret\_name) | The name of the secret set in AWS for the Github App for SSO configuration | `string` | `"pop-platform_local_argo_github_app_secret"` | no |
| <a name="input_argo_github_app_token_template_app_id"></a> [argo\_github\_app\_token\_template\_app\_id](#input\_argo\_github\_app\_token\_template\_app\_id) | The GitHub App ID for the token template | `string` | `""` | no |
| <a name="input_argo_github_app_token_template_enterprise_base_url"></a> [argo\_github\_app\_token\_template\_enterprise\_base\_url](#input\_argo\_github\_app\_token\_template\_enterprise\_base\_url) | The GitHub Enterprise base URL | `string` | `""` | no |
| <a name="input_argo_github_app_token_template_installation_id"></a> [argo\_github\_app\_token\_template\_installation\_id](#input\_argo\_github\_app\_token\_template\_installation\_id) | The GitHub App Installation ID for the token template | `string` | `""` | no |
| <a name="input_argo_github_app_token_template_private_key"></a> [argo\_github\_app\_token\_template\_private\_key](#input\_argo\_github\_app\_token\_template\_private\_key) | The GitHub App private key for the token template | `string` | `""` | no |
| <a name="input_argo_github_app_token_template_url"></a> [argo\_github\_app\_token\_template\_url](#input\_argo\_github\_app\_token\_template\_url) | The URL to the GitHub App token template | `string` | `""` | no |
| <a name="input_argo_github_token_password"></a> [argo\_github\_token\_password](#input\_argo\_github\_token\_password) | The GitHub token to authenticate with | `string` | `""` | no |
| <a name="input_argo_github_token_template_url"></a> [argo\_github\_token\_template\_url](#input\_argo\_github\_token\_template\_url) | The URL to the GitHub token template | `string` | `""` | no |
| <a name="input_argo_github_token_username"></a> [argo\_github\_token\_username](#input\_argo\_github\_token\_username) | The GitHub user to authenticate with, defaults to token user `token-user` | `string` | `""` | no |
| <a name="input_argo_notifications_ms_teams_secret_name"></a> [argo\_notifications\_ms\_teams\_secret\_name](#input\_argo\_notifications\_ms\_teams\_secret\_name) | The name of the secret for Argo notifications that contains webhook url for MS teams | `string` | `""` | no |
| <a name="input_argo_url"></a> [argo\_url](#input\_argo\_url) | The ArgoCD URL | `string` | `"https://localhost:8080"` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS account ID for the ArgoCD service account IAM role | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for the ArgoCD service account IAM role | `string` | `"us-east-1"` | no |
| <a name="input_base_argo_projects"></a> [base\_argo\_projects](#input\_base\_argo\_projects) | List of base Argo projects to create | <pre>list(object({<br/>    name        = string<br/>    namespace   = string<br/>    description = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "description": "ArgoCD Project for Core Applications",<br/>    "name": "core-applications",<br/>    "namespace": "argocd"<br/>  },<br/>  {<br/>    "description": "ArgoCD Project for Environment Applications",<br/>    "name": "environment-applications",<br/>    "namespace": "argocd"<br/>  }<br/>]</pre> | no |
| <a name="input_controller_replicas"></a> [controller\_replicas](#input\_controller\_replicas) | The number of ArgoCD controller replicas | `number` | `1` | no |
| <a name="input_eks_cli_extra_args"></a> [eks\_cli\_extra\_args](#input\_eks\_cli\_extra\_args) | Extra arguments to pass to the EKS CLI | `list(string)` | `[]` | no |
| <a name="input_eks_cluster_arn"></a> [eks\_cluster\_arn](#input\_eks\_cluster\_arn) | The EKS cluster ARN | `string` | n/a | yes |
| <a name="input_eks_cluster_certificate_authority_data"></a> [eks\_cluster\_certificate\_authority\_data](#input\_eks\_cluster\_certificate\_authority\_data) | The base64 encoded certificate data required to communicate with the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#input\_eks\_cluster\_endpoint) | The endpoint for the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | The EKS cluster to deploy ArgoCD to | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment | `string` | n/a | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | The GitHub organization | `string` | `"liatrio"` | no |
| <a name="input_platformTeam"></a> [platformTeam](#input\_platformTeam) | The GitHub Team to give admin access to the ArgoCD application | `string` | `"platform"` | no |
| <a name="input_pre_reqs"></a> [pre\_reqs](#input\_pre\_reqs) | n/a | `any` | `{}` | no |
| <a name="input_redis_ha_enabled"></a> [redis\_ha\_enabled](#input\_redis\_ha\_enabled) | Enable Redis HA | `bool` | `true` | no |
| <a name="input_redis_ha_replicas"></a> [redis\_ha\_replicas](#input\_redis\_ha\_replicas) | The number of Redis HA replicas | `number` | `2` | no |
| <a name="input_reposerver_replicas"></a> [reposerver\_replicas](#input\_reposerver\_replicas) | The number of ArgoCD repo server replicas | `number` | `2` | no |
| <a name="input_server_replicas"></a> [server\_replicas](#input\_server\_replicas) | The number of ArgoCD server replicas | `number` | `2` | no |
| <a name="input_trusted_role_arns"></a> [trusted\_role\_arns](#input\_trusted\_role\_arns) | The ARNs of the trusted roles | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argo_base_projects"></a> [argo\_base\_projects](#output\_argo\_base\_projects) | n/a |
| <a name="output_argocd_helm_release_metadata"></a> [argocd\_helm\_release\_metadata](#output\_argocd\_helm\_release\_metadata) | n/a |
| <a name="output_argocd_namespace"></a> [argocd\_namespace](#output\_argocd\_namespace) | n/a |
| <a name="output_aws_iam_role_argocd_arn"></a> [aws\_iam\_role\_argocd\_arn](#output\_aws\_iam\_role\_argocd\_arn) | n/a |
<!-- END_TF_DOCS -->