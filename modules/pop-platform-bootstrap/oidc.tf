resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["74f3a68f16524f15424927704c9506f55a9316bd"]

  tags = {
    Name = "GitHubOIDCProvider"
  }
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.repo_name}:environment:${var.env}"]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "github_actions_role" {
  name               = "GitHubActionsRole"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
  tags = {
    Name = "GitHubActionsRole"
  }
}

#trivy:ignore:avd-aws-0057 - may only need sts:AssumeRoleWithWebIdentity, and s3:read to run plan; but may need full access for Apply
data "aws_iam_policy_document" "github_actions_policy" {
  statement {
    actions = [
      "*",
      # "sts:AssumeRoleWithWebIdentity",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "github_actions_policy" {
  name        = "github-actions-policy"
  description = "This policy allows GitHub Actions to assume the role"
  policy      = data.aws_iam_policy_document.github_actions_policy.json
}

resource "aws_iam_role_policy_attachment" "github_actions_policy_attachment" {
  policy_arn = aws_iam_policy.github_actions_policy.arn
  # policy_arn = aws_iam_openid_connect_provider.github.arn
  role = aws_iam_role.github_actions_role.name
}
