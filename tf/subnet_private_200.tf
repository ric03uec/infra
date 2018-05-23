#######################################################
############# Private_200 Subnet configuration
#######################################################

resource "aws_subnet" "subnet_private_200" {
  vpc_id            = "${aws_vpc.vpc_global.id}"
  cidr_block        = "${var.cidr_block_subnet_private_200}"
  availability_zone = "${var.avl_zone_02}"

  tags = {
    Name = "subnet_private_200_${var.environment_name}"
  }
}
