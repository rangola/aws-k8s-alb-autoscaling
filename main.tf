# Create VPC resources
module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  vpc_cidr    = "10.0.0.0/16"
}

# Create EKS resources
module "eks" {
  source             = "./modules/eks"
  environment        = var.environment
  cluster_name       = "my-eks-cluster"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.private_subnets
  asg_desired_count  = 3
  asg_max_size       = 6
  worker_instance_type = "t3.medium"
}

# Create ALB resources
module "alb" {
  source             = "./modules/alb"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.private_subnets
  security_group_ids = [module.eks.worker_security_group_id]
}

# Create IAM resources
module "iam" {
  source             = "./modules/iam"
  environment        = var.environment
}

# Output the EKS cluster endpoint and worker node IAM role ARN
output "kubeconfig" {
  value = module.eks.kubeconfig
}

output "worker_iam_role_arn" {
  value = module.iam.eks_worker_nodes_role_arn
}
