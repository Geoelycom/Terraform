variable "web_port" {
  description = "Web Port"
  type = number
  default = 80
}

variable "aws_region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

variable "enable_dns" {
  description = "DNS support for the vpc"
  type = bool
  default = "true"
}

variable "azs" {
  description = "Availability Zones"
  type = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# type map
variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0c55b159cbfafe1f0"
    "us-west-2" = "ami-0b69ea66ff7391e80"
  }
  
}

variable "my_instance" {
  type = turple([string, number, bool])
  default = [ "t2.micro", 1, true ]
}

# type of object
variable "egress_dsg" {
  type = object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr_blocks = list(string)
  })
  default = {
   from_port = 0,
   to_port = 65365,
   protocol = "tcp",
   cidr_blocks = [ "100.0.0/16", "200.0.0.0/16" ]
  }
}