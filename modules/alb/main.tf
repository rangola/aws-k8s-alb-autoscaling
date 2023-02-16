variable "alb_name" {
  type        = string
  description = "Name of the Application Load Balancer"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks of the public subnets"
}

variable "target_group_name" {
  type        = string
  description = "Name of the target group"
}

variable "target_group_port" {
  type        = number
  description = "Port on which the target group is listening"
}

variable "target_group_protocol" {
  type        = string
  description = "Protocol used by the target group"
}

variable "listener_port" {
  type        = number
  description = "Port on which the Application Load Balancer is listening"
}

variable "listener_protocol" {
  type        = string
  description = "Protocol used by the Application Load Balancer listener"
}

variable "alb_security_group_rules" {
  type        = list(object({
    description      = string
    type             = string
    from_port        = number
    to_port          = number
    protocol         = string
    security_groups  = list(string)
    cidr_blocks      = list(string)
  }))
  description = "List of security group rules for the Application Load Balancer"
}

variable "target_group_health_check" {
  type        = list(object({
    path                = string
    port                = string
    protocol            = string
    timeout             = number
    interval            = number
    healthy_threshold   = number
    unhealthy_threshold = number
  }))
  description = "Health check settings for the target group"
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "${var.alb_name}-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = var.listener_protocol
    cidr_blocks = [var.public_subnet_cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.alb_security_group_rules

    content {
      description     = ingress.value.description
      type            = ingress.value.type
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      security_groups = ingress.value.security_groups
      cidr_blocks     = ingress.value.cidr_blocks
    }
  }
}

resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnet_ids

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name_prefix      = "${var.target_group_name}-"
  port             = var.target_group_port
  protocol         = var.target_group_protocol
  vpc_id           = module.vpc.vpc_id
  health_check     = var.target_group_health_check

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = module.asg.asg_id
  port             = var.target_group_port
}
