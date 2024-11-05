# ArgoCD Application Set Generator Module
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
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.15.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.12.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.application_set](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [time_sleep.wait_time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_disable_sync"></a> [allow\_disable\_sync](#input\_allow\_disable\_sync) | Allow disabling sync for the application set | `bool` | `false` | no |
| <a name="input_argo_application_set_helm_release_namespace"></a> [argo\_application\_set\_helm\_release\_namespace](#input\_argo\_application\_set\_helm\_release\_namespace) | The ArgoCD application namespace for the application set to deploy in | `string` | n/a | yes |
| <a name="input_argo_applications_repourl"></a> [argo\_applications\_repourl](#input\_argo\_applications\_repourl) | The ArgoCD application repository URL. Example: https://github.com/liatrio/pop-platform-core//applications.yaml?ref=main | `string` | n/a | yes |
| <a name="input_argo_notifications_ms_teams_secret_name"></a> [argo\_notifications\_ms\_teams\_secret\_name](#input\_argo\_notifications\_ms\_teams\_secret\_name) | The name of the secret for Argo notifications that contains webhook url for MS teams | `string` | `""` | no |
| <a name="input_argo_project_name"></a> [argo\_project\_name](#input\_argo\_project\_name) | The ArgoCD project name for the application set to deploy in | `string` | `"default"` | no |
| <a name="input_argocd_helm_release_metadata"></a> [argocd\_helm\_release\_metadata](#input\_argocd\_helm\_release\_metadata) | The metadata for the ArgoCD Helm release | `any` | `{}` | no |
| <a name="input_eks_cli_extra_args"></a> [eks\_cli\_extra\_args](#input\_eks\_cli\_extra\_args) | Extra arguments to pass to the EKS CLI | `list(string)` | `[]` | no |
| <a name="input_eks_cluster_certificate_authority_data"></a> [eks\_cluster\_certificate\_authority\_data](#input\_eks\_cluster\_certificate\_authority\_data) | The base64 encoded certificate data required to communicate with the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#input\_eks\_cluster\_endpoint) | The endpoint for the EKS cluster. | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | The EKS cluster to deploy ArgoCD to | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Application Set Name | `string` | n/a | yes |
| <a name="input_patches"></a> [patches](#input\_patches) | List of patches to apply to the application set | <pre>list(object({<br/>    version = optional(string)<br/>    kind    = string<br/>    name    = string<br/>    operations = list(object({<br/>      op    = string<br/>      path  = string<br/>      value = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_pre_reqs"></a> [pre\_reqs](#input\_pre\_reqs) | n/a | `any` | `{}` | no |
| <a name="input_sleep_time"></a> [sleep\_time](#input\_sleep\_time) | The time to sleep between argo application set deletion and argo deletion | `string` | `"50s"` | no |
<!-- END_TF_DOCS -->