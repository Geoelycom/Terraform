terraform {
  # cloud {
  #   organization = "Easepay"

  #   workspaces {
  #     name = "Geo-terraform"
  #   }
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    required_version = ">= 1.0.0"
  }

  ## When we are trying to use VSC-DRIVEN workflow for hcp, WE DONT NEED to define the cloud block configuration in our terraform block. hence we commented it out
}
