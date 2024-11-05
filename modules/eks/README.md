# EKS Terraform module

## Description

This Terraform module uses the AWS Community module for EKS along with a number of additional resources to support the pop-platform-Core module.

## Contributing

PRs to the repository are welcome. Please reach out to the @platform-all team for review.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.8.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_iam_policy_eks_assume_role"></a> [aws\_iam\_policy\_eks\_assume\_role](#module\_aws\_iam\_policy\_eks\_assume\_role) | terraform-aws-modules/iam/aws//modules/iam-policy | 5.46.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 20.24.3 |
| <a name="module_iam_eks_role"></a> [iam\_eks\_role](#module\_iam\_eks\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | 5.46.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_access_entry.admin_arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry) | resource |
| [aws_eks_access_policy_association.admin_arns_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_access_policy_association.admin_arns_cluster_admin_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_addon.addons](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_role_arns"></a> [admin\_role\_arns](#input\_admin\_role\_arns) | Additional Admin role arns for roles that should have admin access and cluster admin to the EKS cluster | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The cluster name for the EKS cluster | `string` | n/a | yes |
| <a name="input_desired_nodes_size"></a> [desired\_nodes\_size](#input\_desired\_nodes\_size) | The desired number of nodes in the node group. | `number` | `2` | no |
| <a name="input_eks_add_ons"></a> [eks\_add\_ons](#input\_eks\_add\_ons) | Map of EKS addons to enable. Though addon\_name and addon\_version are stated as optional, they must be specified per addon\_resource requirements. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon for more information. | <pre>list(object({<br/>    addon_name                  = optional(string)<br/>    addon_version               = optional(string)<br/>    resolve_conflicts_on_create = optional(string)<br/>    resolve_conflicts_on_update = optional(string)<br/>    service_account_role_arn    = optional(string)<br/>    tags                        = optional(map(string))<br/>    preserve                    = optional(bool)<br/>    configuration_values        = optional(map(any))<br/>  }))</pre> | <pre>[<br/>  {}<br/>]</pre> | no |
| <a name="input_eks_node_group_instance_type"></a> [eks\_node\_group\_instance\_type](#input\_eks\_node\_group\_instance\_type) | The desired instance type for the EKS node group. | `string` | `"t3.medium"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment the EKS cluster is being deployed into | `string` | `"dev"` | no |
| <a name="input_max_nodes_size"></a> [max\_nodes\_size](#input\_max\_nodes\_size) | The maximum number of nodes in the node group. | `number` | `4` | no |
| <a name="input_min_nodes_size"></a> [min\_nodes\_size](#input\_min\_nodes\_size) | The minimum number of nodes in the node group. | `number` | `1` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The IDs of the private subnets in which to create the EKS cluster | `list(string)` | n/a | yes |
| <a name="input_trusted_role_arns"></a> [trusted\_role\_arns](#input\_trusted\_role\_arns) | Trusted role arns that should be able to assume the EKS role | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which to create the EKS cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | ARN of the EKS cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Kubernetes cluster cert data |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for EKS control plane |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Kubernetes Cluster Name |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | value of the OIDC issuer URL for the EKS cluster |
| <a name="output_eks_addon_output"></a> [eks\_addon\_output](#output\_eks\_addon\_output) | Various details about add-ons installed for EKS |
| <a name="output_eks_managed_node_group_role"></a> [eks\_managed\_node\_group\_role](#output\_eks\_managed\_node\_group\_role) | value of the IAM role for the EKS managed node group |
| <a name="output_eks_managed_node_group_role_arn"></a> [eks\_managed\_node\_group\_role\_arn](#output\_eks\_managed\_node\_group\_role\_arn) | value of the IAM role ARN for the EKS managed node group |
<!-- END_TF_DOCS -->
