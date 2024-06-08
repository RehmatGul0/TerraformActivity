# postgresql rds instance that is in private subnet of my_vpc
resource "aws_db_instance" "my_psql_rds_instance" {
  identifier = "my-psql-rds-instance"

  engine         = "postgres"
  engine_version = "16.2" # default latest version

  instance_class = "db.t3.micro" # default instance class


  allocated_storage = 20    # minimum storage size
  storage_type      = "gp2" # default storage type

  username = "postgresql_instance_user"
  password = "postgresql_instance_password"
  db_name  = "my_psql_rds_instance"

  availability_zone = "us-east-1a" # default availability zone

  publicly_accessible = false
  skip_final_snapshot = true


  vpc_security_group_ids = [aws_security_group.my_rds_instance_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.my_private_db_subnet.id

  tags = {
    Name = "My PostgreSQL RDS Instance"
  }
}

resource "aws_db_subnet_group" "my_private_db_subnet" {
  name       = "my_private_db_subnet"
  // Concatenating the private subnets and the private RDS subnet [different availability zone]
  subnet_ids = concat(aws_subnet.my_private_subnet[*].id, [aws_subnet.my_private_rds_subnet.id])
  tags = {
    Name = "My Private DB Subnet Group"
  }
}
