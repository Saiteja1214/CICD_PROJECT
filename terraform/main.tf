resource "docker_network" "cicd_net" {
  name = "cicd_network"
}

resource "docker_image" "node_image" {
  name = "node:18-alpine"
}

resource "docker_container" "app" {
  count = var.instance_count
  name  = "cicd-app-${count.index + 1}"
  image = docker_image.node_image.latest
  networks_advanced {
    name = docker_network.cicd_net.name
  }

  ports {
    internal = 3000
    external = var.base_port + count.index
  }

  volumes {
    host_path      = "${path.module}/../deploy/app_${count.index + 1}"
    container_path = "/usr/src/app"
  }

  command = ["sh", "-c", "cd /usr/src/app || mkdir -p /usr/src/app && npm install 2>/dev/null || true && node index.js"]
  restart = "unless-stopped"
}
