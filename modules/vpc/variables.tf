variable "name" {
  type        = string
  description = "Name of the VPC"
}

variable "cidr_block" {
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
