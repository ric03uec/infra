#######################################################
############# Public Subnet configuration
#######################################################

# Public subnet definition
resource "aws_subnet" "subnet_public_250" {
  vpc_id            = "${aws_vpc.vpc_global.id}"
  cidr_block        = "${var.cidr_block_subnet_public_250}"
  availability_zone = "${var.avl_zone_00}"

  tags = {
    Name = "subnet_public_250_${var.environment_name}"
  }
}

# Internet gateway for public subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc_global.id}"

  tags = {
    Name = "ig_${var.environment_name}"
  }
}

# Route table entry for internet gateway
resource "aws_route_table" "route_table_public" {
  vpc_id = "${aws_vpc.vpc_global.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }

  tags = {
    Name = "route_table_public_${var.environment_name}"
  }
}

# Route table association for internet gateway
# and public subnet
resource "aws_route_table_association" "rt_assn_public" {
  subnet_id      = "${aws_subnet.subnet_public_250.id}"
  route_table_id = "${aws_route_table.route_table_public.id}"
}

# Reverse proxy instance
resource "aws_instance" "reverse_proxy" {
  ami               = "${var.ami_us_east_1_ubuntu1404}"
  availability_zone = "${var.avl_zone_00}"
  instance_type     = "${var.instance_type_proxy}"
  key_name          = "${var.aws_key_name}"
  subnet_id         = "${aws_subnet.subnet_public_250.id}"

  vpc_security_group_ids = [
    "${aws_security_group.sg_public.id}",
  ]

  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }

  tags = {
    Name = "reverse_proxy"
  }
}

resource "aws_eip" "reverse_proxy_eip" {
  vpc             = true
}

resource "aws_eip_association" "reverse_proxy_eip_assoc" {
  instance_id       = "${aws_instance.reverse_proxy.id}"
  allocation_id     = "${aws_eip.reverse_proxy_eip.id}"
}
