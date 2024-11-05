# trivy:ignore:avd-aws-0057 Specify the exact permissions required, and to which resources they should apply instead of using wildcards.
module "aws_iam_role_argocd" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.46.0"

  role_name        = "argocd-server-sa-${var.environment}"
  role_description = "ArgoCD Server Service Account Role"
  create_role      = true

  trusted_role_arns = var.trusted_role_arns
  #trivy:ignore:avd-aws-0057
  inline_policy_statements = [
    {
      sid = "AllowAssumeRole"
      actions = [
        "sts:AssumeRole"
      ]
      effect    = "Allow"
      resources = ["*"]
    }
  ]
  depends_on = [var.pre_reqs]
}
#trivy:avd-aws-0057 - TODO: Specify the exact permissions required, and to which resources they should apply instead of using wildcards.
module "aws_iam_policy_argocd_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.46.0"

  name        = "argocd-server-sa-policy-${var.environment}"
  description = "ArgoCD Server SA Policy"
  #trivy:avd-aws-0057 - TODO: Specify the exact permissions required, and to which resources they should apply instead of using wildcards.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:iam::${var.aws_account_id}:role/argocd-server-sa-${var.environment}"
        ]
      },
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:CreateSecret",
          "secretsmanager:PutSecretValue",
          "secretsmanager:DeleteSecret"
        ]
        Effect = "Allow"
        Resource = [
          var.eks_cluster_arn,
          "arn:aws:secretsmanager:${var.aws_region}:${var.aws_account_id}:secret:pop-platform_${var.environment}_*"
        ]
      }
    ]
  })
  depends_on = [var.pre_reqs]
}

resource "aws_iam_role_policy_attachment" "argocd_service_account" {
  role       = module.aws_iam_role_argocd.iam_role_name
  policy_arn = module.aws_iam_policy_argocd_policy.arn
  depends_on = [var.pre_reqs]
}
