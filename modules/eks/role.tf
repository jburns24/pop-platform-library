# trivy:ignore:avd-aws-0057 -- TODO: You should use the principle of least privilege when defining your IAM policies. This means you should specify each exact permission required without using wildcards, as this could cause the granting of access to certain undesired actions, resources and principals.
module "aws_iam_policy_eks_assume_role" {
  # Description: Policy for EKS Assume Role
  # Related to: module.iam_eks_role
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.46.0"

  name        = "${var.environment}-eks-assume-role"
  description = "EKS Assume Role Policy"

  # trivy:ignore:avd-aws-0057 -- TODO: You should use the principle of least privilege when defining your IAM policies. This means you should specify each exact permission required without using wildcards, as this could cause the granting of access to certain undesired actions, resources and principals.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ]
        Effect = "Allow"
        Resource = [
          "*"
        ]
      }
    ]
  })
}
# trivy:ignore:avd-aws-0057 -- TODO: You should use the principle of least privilege when defining your IAM policies. This means you should specify each exact permission required without using wildcards, as this could cause the granting of access to certain undesired actions, resources and principals.
module "iam_eks_role" {
  # Description: IAM role for EKS access
  # Related to: module.aws_iam_policy_eks_assume_role
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.46.0"

  role_name = "${var.environment}-eks-access-role"

  create_role             = true
  trusted_role_arns       = var.trusted_role_arns
  custom_role_policy_arns = [module.aws_iam_policy_eks_assume_role.arn]
}
