#######################################################
############# Region definition
#######################################################
variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "environment_name" {
  description = "infrastructure environment"
  default     = "staging"
}

variable "avl_zone_00" {
  description = "availability zone"
  default     = "us-east-1a"
}

variable "avl_zone_01" {
  description = "availability zone"
  default     = "us-east-1b"
}

variable "avl_zone_02" {
  description = "availability zone"
  default     = "us-east-1c"
}

#######################################################
############# Credentials for AWS connection
#######################################################
variable "aws_key_name" {
  description = "Key Pair Name used to login to the box"
  default     = "ric03uec"
}

variable "aws_key_filename" {
  description = "Key Pair FileName used to login to the box"
  default     = "mykey.pem"
}

#######################################################
############# VPC Variables
#######################################################

variable "cidr_block_vpc_global" {
  description = "Uber IP addressing for the Network"
  default     = "80.0.0.0/16"
}

variable "cidr_block_subnet_private_100" {
  description = "Private, Non-Internet accessible subnet: 1"
  default     = "80.0.100.0/24"
}

variable "cidr_block_subnet_private_200" {
  description = "Private, Non-Internet accessible subnet: 2"
  default     = "80.0.200.0/24"
}

variable "cidr_block_subnet_public_250" {
  description = "Internet accessible subnet"
  default     = "80.0.250.0/24"
}

variable "sg_subnet_public" {
  description = "Subnet name for public security group"
  default     = "sg_public"
}

#######################################################
############# AMI Variables
#######################################################
variable "instance_type_proxy" {
  //make sure it is compatible with AMI, not all AMIs allow all instance types "
  # default = "c3.xlarge"
  default = "t2.micro"

  description = "AWS Instance type for consul server"
}

variable "ami_us_east_1_ubuntu1404" {
  default     = "ami-841f46ff"
  description = "AWS AMI for us-east-1 Ubuntu 14.04"
}
