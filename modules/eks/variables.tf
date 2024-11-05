
variable "environment" {
  description = "The environment the EKS cluster is being deployed into"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "The cluster name for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the EKS cluster"
  type        = string
}

variable "private_subnets" {
  description = "The IDs of the private subnets in which to create the EKS cluster"
  type        = list(string)
}

variable "trusted_role_arns" {
  description = "Trusted role arns that should be able to assume the EKS role"
  type        = list(string)
  default     = []
}

variable "admin_role_arns" {
  description = "Additional Admin role arns for roles that should have admin access and cluster admin to the EKS cluster"
  type        = list(string)
  default     = []
}

variable "max_nodes_size" {
  description = "The maximum number of nodes in the node group."
  type        = number
  default     = 4
}

variable "min_nodes_size" {
  description = "The minimum number of nodes in the node group."
  type        = number
  default     = 1
}

variable "desired_nodes_size" {
  description = "The desired number of nodes in the node group."
  type        = number
  default     = 2
}

variable "eks_node_group_instance_type" {
  description = "The desired instance type for the EKS node group."
  type        = string
  default     = "t3.medium"
}

variable "eks_add_ons" {
  description = "Map of EKS addons to enable. Though addon_name and addon_version are stated as optional, they must be specified per addon_resource requirements. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon for more information."
  type = list(object({
    addon_name                  = optional(string)
    addon_version               = optional(string)
    resolve_conflicts_on_create = optional(string)
    resolve_conflicts_on_update = optional(string)
    service_account_role_arn    = optional(string)
    tags                        = optional(map(string))
    preserve                    = optional(bool)
    configuration_values        = optional(map(any))
  }))
  default = [{}]
}
