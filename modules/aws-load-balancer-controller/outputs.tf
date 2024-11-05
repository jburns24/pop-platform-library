output "albc_helm_release_metadata" {
  value = helm_release.aws-load-balancer-controller_helm.metadata
}
output "eks_lb_controller_role_arn" {
  value = module.iam_eks_lb_controller_role.iam_role_arn
}
