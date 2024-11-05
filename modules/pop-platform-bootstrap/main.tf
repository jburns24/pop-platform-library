#trivy:ignore:avd-aws-0098 - TODO: Use non-default KMS key for encryption
resource "aws_secretsmanager_secret" "github_app_private_key_pem" {
  name = var.github_pem_secret_name
  # Needs to be manually updated once created
}

#trivy:ignore:avd-aws-0098 - TODO: Use non-default KMS key for encryption
resource "aws_secretsmanager_secret" "pop-platform_argo_github_sso_app_secret" {
  name = var.argo_github_sso_app_secret_secret_name
  # Needs to be manually updated once created
}

#trivy:ignore:avd-aws-0098 - TODO: Use non-default KMS key for encryption
resource "aws_secretsmanager_secret" "pop-platform_global_ghcr_token" {
  name = var.pop-platform_global_ghcr_token_secret_name
  # Needs to be manually updated once created
}

#trivy:ignore:avd-aws-0098 - TODO: Use non-default KMS key for encryption
resource "aws_secretsmanager_secret" "argo_notifications_ms_teams_secret" {
  name = var.argo_notifications_ms_teams_secret_name
  # Needs to be manually updated once created
  lifecycle {
    prevent_destroy = true
  }

}

resource "aws_secretsmanager_secret_version" "argo_notifications_ms_teams_secret_version" {
  secret_id = aws_secretsmanager_secret.argo_notifications_ms_teams_secret.id
  secret_string = jsonencode({
    ms_teams_webhook = "placeholder"
  })
  lifecycle {
    prevent_destroy = true
  }
}