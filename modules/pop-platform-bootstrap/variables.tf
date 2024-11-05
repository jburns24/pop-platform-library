variable "env" {
  description = "The environment that you would like to bootstrap"
  type        = string
}

variable "repo_name" {
  description = "The repository that you would like to OIDC to"
  type        = string
  default     = "liatrio/pop-platform"
}

variable "github_pem_secret_name" {
  description = "The name of the GitHub App private key PEM secret"
  default     = "github_app_private_key_pem"
  type        = string
}

variable "argo_github_sso_app_secret_secret_name" {
  description = "The name of the Argo GitHub App secret"
  default     = "pop-platform_dev_argo_github_app_secret"
  type        = string
}

variable "pop-platform_global_ghcr_token_secret_name" {
  description = "The name of the GitHub Container Registry token secret"
  default     = "pop-platform_global_ghcr_token"
  type        = string
}

variable "argo_notifications_ms_teams_secret_name" {
  description = "The name of the secret for Argo notifications that contains webhook url for MS teams"
  type        = string
  default     = "argo_notifications_dev_teams"
}
variable "name_suffix" {
  description = "The suffix to append to the name of the resources to help avoid naming conflicts"
  type        = string
  default     = ""
  
}