#trivy:ignore:avd-aws-0057 -- TODO: You should use the principle of least privilege when defining your IAM policies. This means you should specify each exact permission required without using wildcards, as this could cause the granting of access to certain undesired actions, resources and principals.
module "iam_eks_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-eks-role"
  version = "5.46.0"

  role_name = "awssm-eso-${var.environment}-role"

  assume_role_condition_test = "StringLike"

  cluster_service_accounts = {
    "pop-platform-${var.environment}-cluster" = ["*:awssm"]
  }
  role_policy_arns = {
    esoAssumePolicy = module.aws_iam_eso_awssm_bootstrap_policy.arn
    RdsAssumePolicy = module.aws_iam_eso_rds_awssm_bootstrap_policy.arn
  }

  depends_on = [var.pre_reqs]
}
#trivy:ignore:avd-aws-0057 -- TODO: You should use the principle of least privilege when defining your IAM policies. This means you should specify each exact permission required without using wildcards, as this could cause the granting of access to certain undesired actions, resources and principals.
module "aws_iam_eso_awssm_bootstrap_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.46.0"

  name        = "awssm-eso-${var.environment}-bootstrap-policy"
  description = "Policy for ESO AWS SM bootstrap"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["secretsmanager:GetSecretValue"],
      "Resource": [
        "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:pop-platform_${var.environment}*",
        "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:pop-platform_portal_${var.environment}*",
        "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:pop-platform_global*"
      ]
    }
  ]
}
EOF

  depends_on = [var.pre_reqs]
}
#trivy:ignore:avd-aws-0057 -- TODO: You should use the principle of least privilege when defining your IAM policies. This means you should specify each exact permission required without using wildcards, as this could cause the granting of access to certain undesired actions, resources and principals.
module "aws_iam_eso_rds_awssm_bootstrap_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.46.0"

  name        = "awssm-eso-${var.environment}-rds-bootstrap-policy"
  description = "Policy for ESO AWS SM RDS bootstrap"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["secretsmanager:GetSecretValue", "secretsmanager:ListSecrets"],
      "Resource": "*"
    }
  ]
}
EOF

  depends_on = [var.pre_reqs]
}
