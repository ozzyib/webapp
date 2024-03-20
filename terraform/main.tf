# Terraform configuration for deploying Docker Swarm cluster

# Define provider
terraform {
  required_version = ">= 0.12"
  required_providers {

    docker = {
      source  = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

# Docker network
resource "docker_network" "webapp_network" {
  name = "webapp_network"
}

# Docker service for app
provider "docker" {
  # Docker provider configuration
}

resource "docker_service" "app" {
  name = "app"

  task_spec {
    container_spec {
      image = "nginx:latest"
    }
  }
}

resource "docker_service" "db" {
  name = "db"

  task_spec {
    container_spec {
      image = "mysql:5.7"
    }
  }
}

resource "docker_service" "web" {
  name = "web"

  task_spec {
    container_spec {
      image = "nginx:latest"
    }
  }

  mode {
    replicated {
      replicas = 3
    }
  }
}



