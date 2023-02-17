# AWS EKS Terraform Project

This project provisions an Amazon Web Services (AWS) Elastic Kubernetes Service (EKS) cluster with a corresponding worker node group using Terraform. The cluster is deployed in a private VPC with an internet-facing Application Load Balancer (ALB) to route traffic to the cluster's nodes. The VPC is provisioned with a set of public and private subnets in multiple Availability Zones (AZs). The worker nodes are launched in an Auto Scaling Group (ASG) and are registered with the EKS cluster.

The project consists of the following main components:

- `vpc`: Defines the networking infrastructure for the EKS cluster, including the VPC, subnets, NAT gateway, and security groups.
- `eks`: Defines the EKS cluster and worker node group resources, including the IAM roles and policies required for the nodes to join the cluster.
- `asg`: Defines the Auto Scaling Group for the worker nodes.
- `alb`: Defines the Application Load Balancer to route traffic to the EKS cluster's nodes.

## Prerequisites

- An AWS account and IAM user with permissions to create the necessary resources.
- AWS CLI installed and configured on your local machine.
- Terraform CLI installed on your local machine.

## Usage

1. Clone this repository to your local machine.
2. Navigate to the root directory of the project.
3. Run `terraform init` to initialize the Terraform configuration.
4. Run `terraform plan` to preview the resources that will be created.
5. Run `terraform apply` to create the resources.
6. After the resources have been created, you can obtain the Kubernetes configuration file by running `aws eks update-kubeconfig --name <cluster_name> --region <region>` and replace `<cluster_name>` and `<region>` with the appropriate values.

## Configuration

The following variables can be configured in the `variables.tf` file:

- `region`: The AWS region where the resources will be created.
- `vpc_cidr`: The CIDR block for the VPC.
- `public_subnets_cidr`: The CIDR blocks for the public subnets.
- `private_subnets_cidr`: The CIDR blocks for the private subnets.
- `alb_subnet_tags`: The tags for the subnets where the Application Load Balancer will be deployed.
- `eks_cluster_name`: The name of the EKS cluster.
- `eks_cluster_version`: The Kubernetes version for the EKS cluster.
- `eks_worker_node_instance_type`: The instance type for the worker nodes.
- `eks_worker_node_desired_capacity`: The desired capacity for the worker node group in the ASG.
- `eks_worker_node_min_size`: The minimum size for the worker node group in the ASG.
- `eks_worker_node_max_size`: The maximum size for the worker node group in the ASG.

## Outputs

The following outputs are defined in the `outputs.tf` file:

- `eks_cluster_endpoint`: The endpoint URL for the EKS cluster.
- `eks_cluster_ca_data`: The base64-encoded certificate authority data for the EKS cluster.
- `alb_dns_name`: The DNS name for the Application Load Balancer.
- `alb_zone_id`: The Route 53 zone ID for the Application Load Balancer.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for more information.
