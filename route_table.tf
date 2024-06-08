# Creating route tables for public and private subnets

# Creating a route table for public subnets
resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gw.id
  }
  tags = {
    Name = "My Public Route Table"
  }
}
# Associating the public route table with public subnets
resource "aws_route_table_association" "public_rt_association" {
  count          = 3
  subnet_id      = aws_subnet.my_public_subnet[count.index].id
  route_table_id = aws_route_table.my_public_rt.id
}

# Creating a route table for private subnets
resource "aws_route_table" "my_private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gw.id
  }
  tags = {
    Name = "My Private Route Table"
  }
}
# Associating the private route table with private subnets
resource "aws_route_table_association" "private_rt_association" {
  count          = 3
  subnet_id      = aws_subnet.my_private_subnet[count.index].id
  route_table_id = aws_route_table.my_private_rt.id
}
