output "container_names" {
  value = [for c in docker_container.app : c.name]
}

output "container_ports" {
  value = [for c in docker_container.app : {name = c.name, host_port = c.ports[0].external} ]
}
