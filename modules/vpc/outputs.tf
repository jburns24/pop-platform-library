output "vpc_id" {
  description = "Name of the VPC"
  value       = length(data.aws_vpc.existing_vpc) > 0 ? try(data.aws_vpc.existing_vpc[0].id, null) : module.vpc[0].vpc_id
}

output "private_subnets" {
  value = length(var.private_subnets) > 0 ? try([for subnet in data.aws_subnet.existing_private_subnets : subnet.id], null) : module.vpc[0].private_subnets
}
