Terraform code for AWS infrastructure.
A VPC with the help of Terraform having following attributes;   
- 3 Public and 3 Private Subnets.   
- NAT GW for Private Subnets.   
- IGW for Public Subnets.   
- 1 Route Table for Private Subnets.   
- 1 Route Table for Public Subnets.   
- Launch 3 EC2 instances with any OS of your choosing and install Nginx, Docker, NodeJS 20 via ec2 user data.   
- Launch 1 RDS in Create Private Subnet. ( MySQL or PSQL )   
- Security Groups for each EC2 and RDS

A Load Balancer to be attached on EC2 instances that are in Private Subnets for accessing the Frontend and Backend Application
