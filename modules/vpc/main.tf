data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

data "aws_vpc" "existing_vpc" {
  count = var.vpc_id == "" ? 0 : 1
  id    = var.vpc_id
}

data "aws_subnet" "existing_private_subnets" {
  for_each = toset(var.private_subnets)
  id       = each.value
}



# trivy:ignore:avd-aws-0102 Critical: Set specific allowed ports
# trivy:ignore:avd-aws-0105 Critial: Set a more restrictive cidr range
# trivy:ignore:avd-aws-0178 Medium: Enable flow logs for VPC
module "vpc" {
  count   = var.vpc_id == "" && var.vpc_cidr != "" ? 1 : 0
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.14.0"

  # enable_flow_log = true
  name = "${var.environment}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 48)]
  intra_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 52)]

  enable_nat_gateway = true
  single_nat_gateway = true

  #one_nat_gateway_per_az = false
  #enable_dns_hostnames   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    Name = "${var.environment}-vpc"
  }
}
