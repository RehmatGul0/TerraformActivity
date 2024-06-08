# Creating public and private subnets in the VPC

# Creating public subnets in the VPC
resource "aws_subnet" "my_public_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "my-pub-subnet-${count.index}"
  }
}

# Creating private subnets in the VPC
resource "aws_subnet" "my_private_subnet" {
  count             = 3
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.${count.index + 3}.0/24" # The private subnets start from 3 [+3] because the public subnets are 0, 1, and 2
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-pvt-subnet-${count.index}"
  }
}


# Creating a private subnets in the VPC for the other availability zone (us-east-1b) for RDS instance
resource "aws_subnet" "my_private_rds_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.6.0/24" # The private subnet is 6 because the public subnets are 0, 1, and 2 and the private subnets are 3 and 4
  availability_zone = "us-east-1b"
  tags = {
    Name = "my-pvt-subnet-6"
  }
}

locals {
  fe_pvt_subnet = 0
  be_pvt_subnet = 1
  bi_pvt_subnet = 2
  bastion_public_subnet = 0
}