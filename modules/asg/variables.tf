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

variable "asg_name" {
  type        = string
  description = "Name of the Auto Scaling Group"
}

variable "ami_name" {
  type        = string
  description = "Name of the Amazon Machine Image (AMI) used by the Auto Scaling Group"
}

variable "ami_virtualization_type" {
  type        = string
  description = "Virtualization type of the Amazon Machine Image (AMI) used by the Auto Scaling Group"
}

variable "ami_owner_id" {
  type        = string
  description = "Owner ID of the Amazon Machine Image (AMI) used by the Auto Scaling Group"
}

variable "instance_type" {
  type        = string
  description = "Instance type of the EC2 instances in the Auto Scaling Group"
}

variable "iam_instance_profile" {
  type        = string
  description = "Name of the IAM instance profile used by the EC2 instances in the Auto Scaling Group"
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair used by the Auto Scaling Group instances"
}