# Creating an Elastic IP for the NAT gateway
resource "aws_eip" "my_nat_eip" {
  domain = "vpc"
  tags = {
    Name = "my-nat-elasticip"
  }
}

# Creating a NAT gateway in my VPC
resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.my_nat_eip.id
  subnet_id     = aws_subnet.my_public_subnet[0].id
  tags = {
    Name = "my-nat-gateway"
  }
  depends_on = [aws_eip.my_nat_eip]
}