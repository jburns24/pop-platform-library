variable "environment" {
  description = "The environment name"
  type        = string
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}
variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
variable "vpc_id" {
  description = "The ID of the VPC in which to create the EKS cluster."
  type        = string
}
variable "aws_region" {
  description = "The AWS region in which to create the EKS cluster."
  type        = string
}
variable "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  type        = string
}
variable "eks_cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster"
  type        = string
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
