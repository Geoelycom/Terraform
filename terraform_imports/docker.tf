# Terraform configuration
# Configuration-driven import relies on the import block, which has two required arguments:

# - resource_type: The type of resource to import, in this case, docker_container.
# - resource_name: The name of the resource to import, in this case, my_container.

import {
  id = "305226eb8001ec8363cf1c2500b63566651362a7dbd45ada90b7163e33d8d215"
  to = docker_container.web
}

# generating configuration with the cli is better than manually defining the resources  by using
# terraform plan -generate-config-out=generated.tf flag.

# The import block is used to import existing resources into Terraform state. The id argument specifies the ID of the resource to import, and the to argument specifies the name of the resource in the Terraform configuration.

resource "docker_image" "nginx" {
  name = "nginx:latest"
}