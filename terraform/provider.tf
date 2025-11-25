terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  registry_auth {
    address  = "https://docker.io"
    username = var.dockerhub_username
    password = var.dockerhub_password
  }
}