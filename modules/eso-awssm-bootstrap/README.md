<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.8.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_iam_eso_awssm_bootstrap_policy"></a> [aws\_iam\_eso\_awssm\_bootstrap\_policy](#module\_aws\_iam\_eso\_awssm\_bootstrap\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 5.46.0 |
| <a name="module_aws_iam_eso_rds_awssm_bootstrap_policy"></a> [aws\_iam\_eso\_rds\_awssm\_bootstrap\_policy](#module\_aws\_iam\_eso\_rds\_awssm\_bootstrap\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | 5.46.0 |
| <a name="module_iam_eks_role"></a> [iam\_eks\_role](#module\_iam\_eks\_role) | terraform-aws-modules/iam/aws//modules/iam-eks-role | 5.46.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS region | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | n/a | yes |
| <a name="input_pre_reqs"></a> [pre\_reqs](#input\_pre\_reqs) | n/a | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_awssm_arn"></a> [awssm\_arn](#output\_awssm\_arn) | n/a |
<!-- END_TF_DOCS -->