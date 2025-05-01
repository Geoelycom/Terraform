# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "305226eb8001ec8363cf1c2500b63566651362a7dbd45ada90b7163e33d8d215"
resource "docker_container" "web" {
  env   = []
  image = docker_image.nginx.image_id
  name  = "hashicorp-import"
  ports {
    external = 8081
    internal = 80
    ip       = "0.0.0.0"
    protocol = "tcp"
  }
}

# its possible to bring some resources under terraform management by using the terraform import command. this is often the case for resources defined by a single unique ID or Tag, such as Docker images

# terraform import docker_container.web 305226eb8001ec8363cf1c2500b63566651362a7dbd45ada90b7163e33d8d215

# In the above generated.tf file, the docker_container.web resource specifies the SHA256 hash ID of the image used to create the container. This is how Docker stores the image ID internally, so the import operation loaded the image ID directly into your state. However, identifying the image by its tag or name would make your configuration easier to understand.
# but we can make it easily readable by using the image name instead of the sha256 hash. To do this, we can use the docker_image data source to look up the image by its name and tag. The data source will return the SHA256 hash ID of the image, which we can then use in our docker_container resource.
# we retrieve it with the following command: 
# docker image inspect -f {{.RepoTags}} `docker inspect --format="{{.Image}}" hashicorp-import`

# include it into the resources block : name: "nginx:latest"