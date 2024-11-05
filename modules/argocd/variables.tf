variable "aws_account_id" {
  description = "AWS account ID for the ArgoCD service account IAM role"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the ArgoCD service account IAM role"
  type        = string
  default     = "us-east-1"
}

variable "eks_cluster_name" {
  description = "The EKS cluster to deploy ArgoCD to"
  type        = any
}

variable "eks_cluster_arn" {
  description = "The EKS cluster ARN"
  type        = string
}

variable "argo_github_app_token_template_app_id" {
  description = "The GitHub App ID for the token template"
  type        = string
  default     = ""
}

variable "argo_github_app_token_template_installation_id" {
  description = "The GitHub App Installation ID for the token template"
  type        = string
  default     = ""
}

variable "argo_github_app_token_template_private_key" {
  description = "The GitHub App private key for the token template"
  type        = string
  default     = ""
}

variable "argo_github_app_token_template_url" {
  description = "The URL to the GitHub App token template"
  type        = string
  default     = ""
}

variable "argo_github_app_token_template_enterprise_base_url" {
  description = "The GitHub Enterprise base URL"
  type        = string
  default     = ""
}

variable "argo_github_token_template_url" {
  description = "The URL to the GitHub token template"
  type        = string
  default     = ""
}

variable "argo_github_token_username" {
  description = "The GitHub user to authenticate with, defaults to token user `token-user`"
  type        = string
  default     = ""
}

variable "argo_github_token_password" {
  description = "The GitHub token to authenticate with"
  type        = string
  default     = ""
}

variable "server_replicas" {
  description = "The number of ArgoCD server replicas"
  type        = number
  default     = 2
}

variable "redis_ha_enabled" {
  description = "Enable Redis HA"
  type        = bool
  default     = true
}

variable "redis_ha_replicas" {
  description = "The number of Redis HA replicas"
  type        = number
  default     = 2
}

variable "controller_replicas" {
  description = "The number of ArgoCD controller replicas"
  type        = number
  default     = 1
}

variable "reposerver_replicas" {
  description = "The number of ArgoCD repo server replicas"
  type        = number
  default     = 2
}
variable "applicationset_replicas" {
  description = "The number of ArgoCD application set replicas"
  type        = number
  default     = 2
}

variable "argo_url" {
  description = "The ArgoCD URL"
  type        = string
  default     = "https://localhost:8080"
}

variable "environment" {
  description = "The environment"
  type        = string
}

variable "eks_cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with the EKS cluster."
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster."
  type        = string
}

variable "trusted_role_arns" {
  description = "The ARNs of the trusted roles"
  type        = list(string)
  default     = []
}

variable "github_org" {
  description = "The GitHub organization"
  type        = string
  default     = "liatrio"
}

variable "platformTeam" {
  description = "The GitHub Team to give admin access to the ArgoCD application"
  type        = string
  default     = "platform"
}

variable "base_argo_projects" {
  description = "List of base Argo projects to create"
  type = list(object({
    name        = string
    namespace   = string
    description = string
  }))
  default = [
    {
      name        = "core-applications"
      namespace   = "argocd"
      description = "ArgoCD Project for Core Applications"
    },
    {
      name        = "environment-applications"
      namespace   = "argocd"
      description = "ArgoCD Project for Environment Applications"
    }
  ]
}

variable "argo_github_app_sso_secret_name" {
  description = "The name of the secret set in AWS for the Github App for SSO configuration"
  type        = string
  default     = "pop-platform_local_argo_github_app_secret"
}

variable "argo_notifications_ms_teams_secret_name" {
  description = "The name of the secret for Argo notifications that contains webhook url for MS teams"
  type        = string
  default     = ""
}

variable "albc_helm_release_metadata" {
  description = "The metadata for the AWS Load Balancer Controller Helm release"
  type        = any
  default     = {}
}

variable "eks_cli_extra_args" {
  description = "Extra arguments to pass to the EKS CLI"
  type        = list(string)
  default     = []
}

variable "pre_reqs" {
  description = ""
  type        = any
  default     = {}
}
