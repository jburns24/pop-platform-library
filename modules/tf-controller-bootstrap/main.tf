module "iam_eks_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-eks-role"
  version = "5.46.0"

  role_name = "tf-controller-${var.environment}-role"

  assume_role_condition_test = "StringLike"

  cluster_service_accounts = {
    "pop-platform-${var.environment}-cluster" = ["*:tf-runner"]
  }
  role_policy_arns = {
    TfAssumePolicy = module.aws_iam_tf_controller_bootstrap_policy.arn
  }

  depends_on = [var.pre_reqs]
}

#trivy:ignore:avd-aws-0057
module "aws_iam_tf_controller_bootstrap_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.46.0"

  name        = "tf-controller-${var.environment}-bootstrap-policy"
  description = "Policy for Bootstrap TF Controller"
  #trivy:ignore:avd-aws-0057
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

  depends_on = [var.pre_reqs]
}
