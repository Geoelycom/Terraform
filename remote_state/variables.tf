variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type = string
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
  type = string
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "Provisioned by Terraform"
  type = string
}

variable "public_cidr" {
  description = "CIDR block for public route"
  type        = list(string)
}


variable "vpc_cidr_blocks" {
  
}

variable "subnet_cidr_blocks" {
  
}
variable "enable_dns" {
  
}

variable "enable_dns_hostnames" {
  
}
