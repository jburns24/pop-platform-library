variable "environment" {
  description = "The environment name"
  type        = string
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS region"
  type        = string
}
variable "pre_reqs" {
  description = ""
  type        = any
  default     = {}
}
