terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.0"
}


provider "aws" {
  region = "us-east-1"
  
}

resource "aws_instance" "app_server" {
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
}