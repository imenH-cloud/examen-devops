terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {host = "tcp://192.168.1.116:2375"}

resource "docker_image" "examen-devops" {
  name         = "eline2016/examen-devops"
  keep_locally = false
}

resource "docker_container" "examen-devops" {
  image = docker_image.examen-devops.name
  name  = "examen-devops"
  ports {
    internal = 8888
    external = 9999
  }
  restart = "unless-stopped"  # Politique de redémarrage
}
