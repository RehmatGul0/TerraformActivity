# Creating internet gateway in my VPC
resource "aws_internet_gateway" "my_internet_gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_internet_gw"
  }
}
