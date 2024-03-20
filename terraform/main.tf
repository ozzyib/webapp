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
  name   = "webapp_network"
  driver = "overlay"
}

# Docker service for app
provider "docker" {
  # Docker provider configuration
}

resource "docker_service" "app" {
  name = "app"

  task_spec {
    container_spec {
      image   = "node:latest"
      command = ["npm", "start"]
      env = {
        NODE_ENV = "STAGING",
      }
    }

    networks = [docker_network.webapp_network.id]
  }

  endpoint_spec {
    ports {
      target_port    = 3000
      published_port = 3000
      protocol       = "tcp"
    }
  }
}

# Docker service for database

resource "docker_service" "db" {
  name = "db"

  task_spec {
    container_spec {
      image = "mysql:5.7"
      env = {
        MYSQL_ROOT_PASSWORD = "dbxrootpw*"
        MYSQL_DATABASE      = "mydatabase"
        MYSQL_USER          = "user"
        MYSQL_PASSWORD      = "dbxuserpw*"
      }
    }

    networks = [docker_network.webapp_network.id]
  }
}

# Docker service for web
resource "docker_service" "web" {
  name = "web"

  task_spec {
    container_spec {
      image = "nginx:latest"
    }

    networks = [docker_network.webapp_network.id]
  }

  mode {
    replicated {
      replicas = 3
    }
  }
}



