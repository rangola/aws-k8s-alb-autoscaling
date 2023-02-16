variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block of the VPC"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of private subnet CIDR blocks"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "eks_cluster_iam_role_arn" {
  type        = string
  description = "ARN of the IAM role used by the EKS cluster"
}
