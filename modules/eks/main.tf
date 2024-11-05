resource "aws_eks_access_entry" "admin_arns" {
  # Description: Grants access to the EKS cluster for admin roles.
  # Related to: aws_eks_access_policy_association.admin_arns_access_policy, aws_eks_access_policy_association.admin_arns_cluster_admin_access_policy
  for_each          = toset(var.admin_role_arns)
  cluster_name      = module.eks.cluster_name
  principal_arn     = each.value
  type              = "STANDARD"
  kubernetes_groups = ["cluster-admin"]
}

resource "aws_eks_access_policy_association" "admin_arns_access_policy" {
  # Description: Associates the AmazonEKSAdminPolicy with the admin roles for the EKS cluster.
  # Related to: aws_eks_access_entry.admin_arns
  for_each      = toset(var.admin_role_arns)
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = each.value

  access_scope {
    type = "cluster"
  }
  depends_on = [aws_eks_access_entry.admin_arns]
}

resource "aws_eks_access_policy_association" "admin_arns_cluster_admin_access_policy" {
  # Description: Associates the AmazonEKSClusterAdminPolicy with the admin roles for the EKS cluster.
  # Related to: aws_eks_access_entry.admin_arns
  for_each      = toset(var.admin_role_arns)
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = each.value

  access_scope {
    type = "cluster"
  }
  depends_on = [aws_eks_access_entry.admin_arns]
}

#trivy:ignore:avd-aws-0038 - TODO: Enable logging for the EKS control plane
#trivy:ignore:avd-aws-0040 - TODO: EKS running on private subnets
#trivy:ignore:avd-aws-0041 - TODO: EKS running on private subnets
#trivy:ignore:avd-aws-0104 - TODO: Security group rule allows egress to multiple public internet addresses. NEW.
#trivy:ignore:avd-aws-0017 - TODO: CloudWatch log groups are encrypted by default, however, to get the full benefit of controlling key rotation and other KMS aspects a KMS CMK should be used.
module "eks" {
  # Description: Creates and configures the EKS cluster and its managed node groups.
  # Related to: aws_eks_access_entry.admin_arns, aws_eks_access_policy_association.admin_arns_access_policy, aws_eks_access_policy_association.admin_arns_cluster_admin_access_policy, aws_eks_addon.addons
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.3"

  iam_role_use_name_prefix	  = false
  create_cloudwatch_log_group = true
  cluster_enabled_log_types   = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  cluster_name                   = var.cluster_name
  cluster_version                = "1.30"
  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true
  authentication_mode                      = "API_AND_CONFIG_MAP"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_timeouts = {
    create = "15m"
    delete = "15m"
  }

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    "pop-platform-${var.environment}" = {
      name = var.environment # Prefix for the node group name

      instance_types = [var.eks_node_group_instance_type]

      desired_size = var.desired_nodes_size
      max_size     = var.max_nodes_size
      min_size     = var.min_nodes_size

      timeouts = {
        create = "15m"
        delete = "15m"
      }
    }
  }
}

resource "aws_eks_addon" "addons" {
  # Description: Manages EKS add-ons for the cluster.
  # Related to: module.eks
  for_each = { for addon in var.eks_add_ons : addon.addon_name => addon if addon.addon_name != null }

  cluster_name                = module.eks.cluster_name
  addon_name                  = each.value.addon_name != null ? each.value.addon_name : null
  addon_version               = each.value.addon_version != null ? each.value.addon_version : null
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_update != null ? each.value.resolve_conflicts_on_create : null
  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update != null ? each.value.resolve_conflicts_on_update : null
  tags                        = each.value.tags != null ? each.value.tags : null
  service_account_role_arn    = each.value.service_account_role_arn != null ? each.value.service_account_role_arn : null

  configuration_values = each.value.configuration_values != null ? jsonencode(each.value.configuration_values) : null
}
