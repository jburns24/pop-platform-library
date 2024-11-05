provider "kubernetes" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = concat(["eks", "get-token", "--cluster-name", var.eks_cluster_name], var.eks_cli_extra_args)
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = var.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(var.eks_cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = concat(["eks", "get-token", "--cluster-name", var.eks_cluster_name], var.eks_cli_extra_args)
      command     = "aws"
    }
  }
}
