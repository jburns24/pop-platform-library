terraform {
  required_version = ">=1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.70.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.32.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.15.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.12.0"
    }
  }
}
