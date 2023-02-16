resource "aws_autoscaling_group" "asg" {
  name = "${var.name}"
  vpc_zone_identifier = ["${var.subnet_ids}"]
  launch_configuration = "${aws_launch_configuration.lc.name}"
  min_size = "${var.min_size}"
  max_size = "${var.max_size}"
  desired_capacity = "${var.desired_capacity}"
  health_check_type = "${var.health_check_type}"
  health_check_grace_period = "${var.health_check_grace_period}"
  default_cooldown = "${var.default_cooldown}"
  termination_policies = ["${var.termination_policies}"]
  wait_for_capacity_timeout = "${var.wait_for_capacity_timeout}"
  force_delete = "${var.force_delete}"
  tags = [
    {
      key = "Name"
      value = "${var.name}"
      propagate_at_launch = true
    },
    {
      key = "Environment"
      value = "${var.environment}"
      propagate_at_launch = true
    },
    {
      key = "Owner"
      value = "${var.owner}"
      propagate_at_launch = true
    },
    {
      key = "CostCenter"
      value = "${var.cost_center}"
      propagate_at_launch = true
    },
    {
      key = "Application"
      value = "${var.application}"
      propagate_at_launch = true
    },
    {
      key = "Role"
      value = "${var.role}"
      propagate_at_launch = true
    },
    {
      key = "ManagedBy"
      value = "Terraform"
      propagate_at_launch = true
    },
  ]
}

resource "aws_launch_configuration" "lc" {
  name_prefix = "${var.name}"
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  security_groups = ["${var.security_groups}"]
  iam_instance_profile = "${var.iam_instance_profile}"
  user_data = "${var.user_data}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  enable_monitoring = "${var.enable_monitoring}"
  ebs_optimized = "${var.ebs_optimized}"
  root_block_device {
    volume_type = "${var.root_block_device_volume_type}"
    volume_size = "${var.root_block_device_volume_size}"
    delete_on_termination = "${var.root_block_device_delete_on_termination}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

