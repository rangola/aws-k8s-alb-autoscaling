variable "region" {
  description = "The AWS region to deploy the resources."
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  default     = "my-eks-cluster"
}

variable "alb_name" {
  description = "The name of the Application Load Balancer."
  default     = "my-alb"
}

variable "desired_capacity" {
  description = "The desired number of worker nodes in the EKS cluster's worker node group."
  default     = 2
}

variable "max_capacity" {
  description = "The maximum number of worker nodes in the EKS cluster's worker node group."
  default     = 3
}

variable "min_capacity" {
  description = "The minimum number of worker nodes in the EKS cluster's worker node group."
  default     = 1
}

variable "vpc_cidr_block" {
  description = "The IP address range for the VPC."
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  description = "The IP address ranges for the private subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidr_blocks" {
  description = "The IP address ranges for the public subnets."
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "ip_address_range" {
  description = "The default IP address range."
  default     = "10.0.0.3/16"
}
