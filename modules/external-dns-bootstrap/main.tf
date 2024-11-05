#trivy:ignore:avd-aws-0057 -- TODO: You should use the principle of least privilege when defining your IAM policies. This means you should specify each exact permission required without using wildcards, as this could cause the granting of access to certain undesired actions, resources and principals.
module "iam_eks_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-eks-role"
  version = "5.46.0"

  role_name = "eDNS-route53-${var.environment}-role"

  assume_role_condition_test = "StringLike"

  cluster_service_accounts = {
    "pop-platform-${var.environment}-cluster" = ["*:external-dns"]
  }
  role_policy_arns = {
    eDNSroute53AssumePolicy = module.aws_iam_eDNS_bootstrap_policy.arn
  }

  depends_on = [var.pre_reqs]
}
#trivy:ignore:avd-aws-0057 -- TODO: You should use the principle of least privilege when defining your IAM policies. This means you should specify each exact permission required without using wildcards, as this could cause the granting of access to certain undesired actions, resources and principals.
module "aws_iam_eDNS_bootstrap_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.46.0"

  name        = "eDNS-route53-${var.environment}-bootstrap-policy"
  description = "Policy for External-DNS Route53 access bootstrap"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets",
        "route53:ListTagsForResource"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF

  depends_on = [var.pre_reqs]
}
