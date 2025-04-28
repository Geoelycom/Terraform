# configure aws providers
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Create an EC2 instance
resource "aws_instance" "modules" {
  ami = var.ami
  instance_type = "t2.micro"
}