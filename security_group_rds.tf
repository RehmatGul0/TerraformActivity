# Creating a security group for the postgresql db instance
resource "aws_security_group" "my_rds_instance_sg" {
  name        = "postgresql-sg"

  vpc_id = aws_vpc.my_vpc.id # Referencing the VPC created in vpc.tf

  # Ingress rule for PostgreSQL port
  ingress {
    from_port   = 5432
    to_port     = 5432 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My RDS instance security group"
  }
}
