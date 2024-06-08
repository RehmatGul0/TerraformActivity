# Creating EC2 instance in the VPC for Frontend
resource "aws_instance" "my_fe_ubuntu_instance" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.small"

  key_name               = "my_ubuntu_instance"
  vpc_security_group_ids = ["${aws_security_group.my_ec2_instance_sg.id}"]
  subnet_id              = aws_subnet.my_private_subnet[local.fe_pvt_subnet].id

  # tags for the instance
  tags = {
    Name = "My Frontend Ubuntu Instance"
  }

  # roote block device
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  # user data folder
  user_data = templatefile("${path.module}/userdata/userdata_fe.sh", {})
}

# Creating EC2 instance in the VPC for Backend
resource "aws_instance" "my_be_ubuntu_instance" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.small"

  key_name               = "my_ubuntu_instance"
  vpc_security_group_ids = ["${aws_security_group.my_ec2_instance_sg.id}"]
  subnet_id              = aws_subnet.my_private_subnet[local.be_pvt_subnet].id

  # tags for the instance
  tags = {
    Name = "My Backend Ubuntu Instance"
  }

  # roote block device
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  # user data folder
  user_data = templatefile("${path.module}/userdata/userdata_be.sh", {})
}

# Creating EC2 instance in the VPC for BI
resource "aws_instance" "my_bi_ubuntu_instance" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"

  key_name               = "my_ubuntu_instance"
  vpc_security_group_ids = ["${aws_security_group.my_ec2_instance_sg.id}"]
  subnet_id              = aws_subnet.my_private_subnet[local.bi_pvt_subnet].id

  # tags for the instance
  tags = {
    Name = "My BI Ubuntu Instance"
  }

  # roote block device
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  # user data folder
  user_data = templatefile("${path.module}/userdata/userdata_bi.sh", {})
}

# Creating EC2 instance in the VPC for Bastion
resource "aws_instance" "my_bastion_ubuntu_instance" {
    ami           = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"

    key_name                = "my_ubuntu_instance"
    vpc_security_group_ids  = ["${aws_security_group.my_ec2_instance_sg.id}"]
    subnet_id               = aws_subnet.my_public_subnet[local.bastion_public_subnet].id

    # tags for the instance
    tags = {
        Name = "My Bastion Ubuntu Instance"
    }

    # roote block device
    root_block_device {
        volume_size = 8
        volume_type = "gp3"
    }
}

