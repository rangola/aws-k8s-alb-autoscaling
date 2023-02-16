# Configure the AWS provider
provider "aws" {
  region = "us-west-2"
}

# Configure the default IP address range
locals {
  ip_address_range = "10.0.0.3/16"
}
