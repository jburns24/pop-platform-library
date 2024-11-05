output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_certificate_authority_data" {
  description = "Kubernetes cluster cert data"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}

output "cluster_oidc_issuer_url" {
  description = "value of the OIDC issuer URL for the EKS cluster"
  value       = module.eks.cluster_oidc_issuer_url

}
output "eks_managed_node_group_role_arn" {
  description = "value of the IAM role ARN for the EKS managed node group"
  value       = module.eks.eks_managed_node_groups["pop-platform-${var.environment}"].iam_role_arn
}

output "eks_managed_node_group_role" {
  description = "value of the IAM role for the EKS managed node group"
  value       = module.eks.eks_managed_node_groups["pop-platform-${var.environment}"].iam_role_name
}

output "eks_addon_output" {
  description = "Various details about add-ons installed for EKS"
  value = {
    for k, addon in aws_eks_addon.addons : k => {
      arn         = addon.arn
      id          = addon.id
      created_at  = addon.created_at
      modified_at = addon.modified_at
      tags_all    = addon.tags_all
    }
  }
}
