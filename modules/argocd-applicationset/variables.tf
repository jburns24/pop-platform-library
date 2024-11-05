variable "name" {
  type        = string
  description = "Application Set Name"
}

variable "argo_applications_repourl" {
  type        = string
  description = "The ArgoCD application repository URL. Example: https://github.com/liatrio/pop-platform-core//applications.yaml?ref=main"
}

variable "argo_application_set_helm_release_namespace" {
  type        = string
  description = "The ArgoCD application namespace for the application set to deploy in"
}

variable "allow_disable_sync" {
  type        = bool
  description = "Allow disabling sync for the application set"
  default     = false
}

variable "argo_project_name" {
  type        = string
  description = "The ArgoCD project name for the application set to deploy in"
  default     = "default"
}

variable "patches" {
  description = "List of patches to apply to the application set"
  type = list(object({
    version = optional(string)
    kind    = string
    name    = string
    operations = list(object({
      op    = string
      path  = string
      value = string
    }))
  }))
  default = []
}

variable "argocd_helm_release_metadata" {
  description = "The metadata for the ArgoCD Helm release"
  type        = any
  default     = {}
}

variable "eks_cluster_name" {
  description = "The EKS cluster to deploy ArgoCD to"
  type        = any
}

variable "eks_cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with the EKS cluster."
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster."
  type        = string
}

variable "eks_cli_extra_args" {
  description = "Extra arguments to pass to the EKS CLI"
  type        = list(string)
  default     = []
}

variable "sleep_time" {
  description = "The time to sleep between argo application set deletion and argo deletion"
  type        = string
  default     = "50s"
}

variable "pre_reqs" {
  description = ""
  type        = any
  default     = {}
}

variable "argo_notifications_ms_teams_secret_name" {
  description = "The name of the secret for Argo notifications that contains webhook url for MS teams"
  type        = string
  default     = ""
}