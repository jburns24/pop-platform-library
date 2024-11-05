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
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >=2.32.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >=0.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_iam_lb_controller_policy"></a> [aws\_iam\_lb\_controller\_policy](#module\_aws\_iam\_lb\_controller\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 5.46.0 |
| <a name="module_iam_eks_lb_controller_role"></a> [iam\_eks\_lb\_controller\_role](#module\_iam\_eks\_lb\_controller\_role) | terraform-aws-modules/iam/aws//modules/iam-eks-role | 5.46.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.aws-load-balancer-controller_helm](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cert-manager_helm](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.aws-lb-controller](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.cert-manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [time_sleep.helm_wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.ns_wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region in which to create the EKS cluster. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_cli_extra_args"></a> [eks\_cli\_extra\_args](#input\_eks\_cli\_extra\_args) | Extra arguments to pass to the EKS CLI | `list(string)` | `[]` | no |
| <a name="input_eks_cluster_certificate_authority_data"></a> [eks\_cluster\_certificate\_authority\_data](#input\_eks\_cluster\_certificate\_authority\_data) | The certificate authority data for the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#input\_eks\_cluster\_endpoint) | The endpoint for the EKS cluster | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | n/a | yes |
| <a name="input_pre_reqs"></a> [pre\_reqs](#input\_pre\_reqs) | n/a | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which to create the EKS cluster. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_albc_helm_release_metadata"></a> [albc\_helm\_release\_metadata](#output\_albc\_helm\_release\_metadata) | n/a |
| <a name="output_eks_lb_controller_role_arn"></a> [eks\_lb\_controller\_role\_arn](#output\_eks\_lb\_controller\_role\_arn) | n/a |
<!-- END_TF_DOCS -->