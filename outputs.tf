# Output the ID of the VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

# Output the IDs of the private subnets
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

# Output the EKS cluster endpoint
output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

# Output the EKS worker node IAM role ARN
output "eks_worker_node_role_arn" {
  value = module.iam.eks_worker_nodes_role_arn
}

# Output the ARN of the IAM role used by the ALB
output "alb_iam_role_arn" {
  value = module.alb.alb_iam_role_arn
}

# Output the DNS name of the ALB
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

# Output the security group IDs used by the ALB
output "alb_security_group_ids" {
  value = module.alb.alb_security_group_ids
}
