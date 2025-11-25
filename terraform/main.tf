# ----------------------------
# Hello-node image from GHCR
# ----------------------------
resource "docker_image" "hello_node" {
  name = "ghcr.io/naderops/node-hello:master"
}

resource "docker_container" "hello_node" {
  name  = "hello-node"
  image = docker_image.hello_node.name

  ports {
    internal = 3000
    external = 3000
  }

  restart = "always"
}

# ----------------------------
# New Relic log forwarder
# ----------------------------
resource "docker_image" "newrelic_infra_agent" {
  name = "newrelic/infrastructure:latest"
}

resource "docker_container" "newrelic_infra_agent" {
  name  = "fluentbit-service"
  image = docker_image.newrelic_infra_agent.name

  privileged = true
  network_mode = "host"
  pid_mode     = "host"
  capabilities {
    add = ["SYS_PTRACE"]
  }

  env = [
    "NRIA_LICENSE_KEY=${var.newrelic_license_key}",
    "NRIA_LOGGING_ENABLED=true",
    # The following are optional but recommended for better metadata in New Relic
    "NRIA_DISPLAY_NAME=docker-host",
    "NRIA_CUSTOM_ATTRIBUTES={\"environment\":\"development\"}",
  ]

  # Mount necessary host directories for the agent to function
  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
    read_only      = false
  }
  volumes {
    host_path      = "/"
    container_path = "/host"
    read_only      = true
  }
  volumes {
    host_path      = "${path.cwd}/newrelic-infra"
    container_path = "/etc/newrelic-infra"
    read_only      = true
  }

  # Restart policy in case the container stops
  restart = "unless-stopped"

}