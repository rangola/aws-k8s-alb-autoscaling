module "eks" {
  source = "../eks"

  vpc_name                       = var.vpc_name
  vpc_cidr_block                 = var.vpc_cidr_block
  public_subnet_cidr_blocks      = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks     = var.private_subnet_cidr_blocks
  eks_cluster_name               = var.eks_cluster_name
  eks_cluster_iam_role_arn       = var.eks_cluster_iam_role_arn
}

resource "aws_launch_configuration" "asg_launch_config" {
  name_prefix = "${var.asg_name}-launch-config"
  image_id    = data.aws_ami.ami.id
  instance_type = var.instance_type
  security_groups = [module.eks.eks_cluster_security_group_id]
  iam_instance_profile = var.iam_instance_profile
  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              echo "export KUBECONFIG=/tmp/kubeconfig" >> /home/ec2-user/.bashrc
              kubectl config view --raw > /tmp/kubeconfig
              EOF
}

resource "aws_autoscaling_group" "asg" {
  name = var.asg_name
  vpc_zone_identifier = module.eks.vpc_public_subnet_ids
  launch_configuration = aws_launch_configuration.asg_launch_config.id
  target_group_arns = [module.alb_target_group.arn]
  health_check_type = "EC2"
  health_check_grace_period = 300

  tags = [
    {
      key = "Name"
      value = var.asg_name
      propagate_at_launch = true
    },
  ]
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami_virtualization_type]
  }

  owners = [var.ami_owner_id]
}

output "asg_name" {
  value = aws_autoscaling_group.asg.name
}

output "asg_arn" {
  value = aws_autoscaling_group.asg.arn
}
