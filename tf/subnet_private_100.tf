#######################################################
############# Private_100 Subnet configuration
#######################################################

resource "aws_subnet" "subnet_private_100" {
  vpc_id            = "${aws_vpc.vpc_global.id}"
  cidr_block        = "${var.cidr_block_subnet_private_100}"
  availability_zone = "${var.avl_zone_01}"

  tags = {
    Name = "subnet_private_100_${var.environment_name}"
  }
}
