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
