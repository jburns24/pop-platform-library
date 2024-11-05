variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment in which the VPC is being created."
  type        = string
}

variable "vpc_id" {
  description = "The ID for a existing VPC"
  type        = string
  default     = ""
}

variable "private_subnets" {
  description = "The private subnets ID's for the existing VPC"
  type        = list(string)
  default     = []
}
