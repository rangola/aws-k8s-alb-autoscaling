resource "aws_subnet" "subnet" {
  count = "${var.subnet_count}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.name}-subnet-${count.index}"
  }
}
