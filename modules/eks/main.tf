module "vpc" {
  source = "../vpc"

  name                       = var.vpc_name
  cidr_block                 = var.vpc_cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}

resource "aws_eks_cluster" "eks" {
  name     = var.eks_cluster_name
  role_arn = var.eks_cluster_iam_role_arn

  vpc_config {
    subnet_ids = module.vpc.public_subnet_ids
  }

  depends_on = [
    module.vpc,
  ]
}

resource "aws_security_group" "eks_cluster_sg" {
  name_prefix = "${var.eks_cluster_name}-sg"

  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow all traffic from the EKS worker nodes"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"

    security_groups = [aws_security_group.eks_worker_nodes_sg.id]
  }
}

resource "aws_security_group" "eks_worker_nodes_sg" {
  name_prefix = "${var.eks_cluster_name}-worker-sg"

  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow all traffic from the EKS control plane"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    security_groups = [aws_eks_cluster.eks.eks_cluster_security_group_id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["10.0.0.3/16"]
  }
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_security_group_id" {
  value = aws_security_group.eks_cluster_sg.id
}
