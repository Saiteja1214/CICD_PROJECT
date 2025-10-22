terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_test" {
  name  = "cicd-nginx"
  image = docker_image.nginx.name   # ✅ FIXED
  ports {
    internal = 80
    external = 8082
  }
}

output "container_ports" {
  value = [{
    name      = docker_container.nginx_test.name
    host_port = 8082
  }]
}
