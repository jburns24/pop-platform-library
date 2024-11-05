output "argocd_namespace" {
  value = kubernetes_namespace.argocd.id
}
output "argocd_helm_release_metadata" {
  value      = helm_release.argocd.metadata
  depends_on = [kubernetes_namespace.argocd]
}
output "aws_iam_role_argocd_arn" {
  value = module.aws_iam_role_argocd.iam_role_arn
}
output "argo_base_projects" {
  value = helm_release.argo_app_project.metadata
}
