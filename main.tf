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
  region = "us-east-1"
  access_key = "AKIA*************QO"
  secret_key = "DUEjCE************uICOHQD"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "main-vpc"
  }
}

# create a Subnet

resource  "aws_subnet" "web" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.Web_Subnet
  availability_zone = var.subnet_zone
  tags = {
    "Name" = "web-subnet"
  }
}

resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.main_vpc_name} IGW"
  }

}

# ✅ The New, Correct Approach (v5.x and going forward):
# You should not try to modify the default route table anymore. Instead, create your own route table and associate it with your subnet:

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

resource "aws_route_table_association" "web_subnet_assoc" {
  subnet_id = aws_subnet.web.id
  route_table_id = aws_route_table.main_vpc_rt.id
}


resource "aws_default_security_group" "default_sec_group" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }

  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress  {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "default_sec_group"
  }

}

resource "aws_key_pair" "test_ssh_key" {
  key_name = "testing_ssh_key"
  public_key = file("${var.ssh_public_key}")
}


data "aws_ami" "latest_amazon_linux2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "my_vm" {
  ami = data.aws_ami.latest_amazon_linux2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.web.id
  vpc_security_group_ids = [aws_default_security_group.default_sec_group.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.test_ssh_key.key_name

  # user_data = file("entry-script.sh")
  # using provisioners
  connection {
     type = "ssh"
     host = self.public_ip
     user = "ec2-user"
     private_key = file("~/.ssh/test_rsa")
  }
  provisioner "file" {
    source = "./entry-script.sh"
    destination = "/home/ec2-user/entry-script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/entry-script.sh",
      "sudo /home/ec2-user/entry-script.sh",
      "exit"
    ]
    on_failure = continue
  }

  tags = {
    "Name" = "My EC2 Instance - Amazon Linux 2"
  }
}




# A resource block declares a resource of a given type with a given local name. The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside of the scope of a module.

# terraform plan -out=tfplan is a command that creates an execution plan, showing what actions Terraform will take to change the current infrastructure to match the configuration. The -out=tfplan option saves the plan to a file named tfplan, which can be applied later using terraform apply tfplan. This is useful for reviewing the plan before applying it and for sharing the plan with others.

# aws ec2 describe-images \
#   --image-ids ami-0c02fb55956c7d316 \
#   --region us-east-1
