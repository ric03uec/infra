#######################################################
############# VPC Configuration
#######################################################
resource "aws_vpc" "vpc_global" {
  cidr_block           = "${var.cidr_block_vpc_global}"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_${var.environment_name}"
  }
}
