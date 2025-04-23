terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  
}

data "aws_availability_zones" "available" {}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

resource "aws_instance" "app_server" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ssh.id]
  subnet_id = aws_subnet.web.id
  tags = {
    Name = var.instance_name
  }
}


resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.vpc_cidr_blocks
  enable_dns_support = var.enable_dns
  enable_dns_hostnames = var.enable_dns
  tags = {
    Name = "Terraform VPC"
  }
}

resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.subnet_cidr_blocks
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Web Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "rt_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = var.public_cidr[0]
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route Table"
  }
}

resource "aws_route_table_association" "web_subnet_association" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.rt_table.id
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.terraform_vpc.id

  ingress {
    description = "SSH"
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = var.public_cidr
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.public_cidr
  }

  tags = {
    Name = "SSH Security Group"
  }

}