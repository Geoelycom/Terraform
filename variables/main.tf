terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Create a VPC

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "production-vpc"
  }
  enable_dns_support = var.enable_dns
}

# Create a Subnet
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.10./24"
  availability_zone = var.azs[0]
  tags = {
    "Name" = "web-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Web internet Gateway"
  }
}

# Associate the Internet Gateway with the Route Tables
resource "aws_route_table" "main_vpc_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_web_igw.id
  }

  tags = {
    Name = "my_default_rt"
  }
}

# Setting the security group for the instance
resource "aws_default_security_group" "default_sec_group" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }

 ingress {
    from_port = var.web_port
    to_port = var.web_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress  {
    from_port = var.egress_dsg["from_port"]
    to_port = var.egress_dsg["to_port"]
    protocol = var.egress_dsg["protocol"]
    cidr_blocks = var.egress_dsg["cidr_blocks"]
    prefix_list_ids = []
  }
  tags = {
    "Name" = "default_sec_group"
  }
}

# Create an Ec2 instance (Amazon lINUX 2)
resource "aws_instance" "server" {
  ami          = var.amis["${var.var.aws_region}"]
  instance_type = var.my_instance[0]
  cpu_options {
    core_count = var.my_instance[1]
  }
  associate_public_ip_address = var.my_instance[2]
  count = 1
}