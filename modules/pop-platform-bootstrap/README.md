# Bootstrap of Platform terraform state

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

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.pop-platform_terraform_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table.terraform_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.github_actions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.github_actions_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.github_actions_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.pop-platform_terraform_state_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.terraform_state_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.pop-platform_terraform_state_bucket_sse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.terraform_state_bucket_sse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_secretsmanager_secret.argo_notifications_ms_teams_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.github_app_private_key_pem](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.pop-platform_argo_github_sso_app_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.pop-platform_global_ghcr_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.argo_notifications_ms_teams_secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_iam_policy_document.github_actions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argo_github_sso_app_secret_secret_name"></a> [argo\_github\_sso\_app\_secret\_secret\_name](#input\_argo\_github\_sso\_app\_secret\_secret\_name) | The name of the Argo GitHub App secret | `string` | `"pop-platform_dev_argo_github_app_secret"` | no |
| <a name="input_argo_notifications_ms_teams_secret_name"></a> [argo\_notifications\_ms\_teams\_secret\_name](#input\_argo\_notifications\_ms\_teams\_secret\_name) | The name of the secret for Argo notifications that contains webhook url for MS teams | `string` | `"argo_notifications_dev_teams"` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment that you would like to bootstrap | `string` | n/a | yes |
| <a name="input_github_pem_secret_name"></a> [github\_pem\_secret\_name](#input\_github\_pem\_secret\_name) | The name of the GitHub App private key PEM secret | `string` | `"github_app_private_key_pem"` | no |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | The repository that you would like to OIDC to | `string` | `"liatrio/pop-platform"` | no |
| <a name="input_pop-platform_global_ghcr_token_secret_name"></a> [pop-platform\_global\_ghcr\_token\_secret\_name](#input\_pop-platform\_global\_ghcr\_token\_secret\_name) | The name of the GitHub Container Registry token secret | `string` | `"pop-platform_global_ghcr_token"` | no |
<!-- END_TF_DOCS -->