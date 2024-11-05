<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.8.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sqs"></a> [sqs](#module\_sqs) | terraform-aws-modules/sqs/aws | 4.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sqs_fifo_name"></a> [sqs\_fifo\_name](#input\_sqs\_fifo\_name) | Name for aws SQS fifo queue | `string` | `"fifo-queue"` | no |
<!-- END_TF_DOCS -->