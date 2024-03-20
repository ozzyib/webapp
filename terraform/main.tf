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

# Azure Provider configuration
provider "azurerm" {
  features {}
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


##############################
#      Azure resources       #
##############################


 # Create a resource group
# resource "azurerm_resource_group" "rg" {
#   name     = "oz-rg"
#   location = "uksouth"
# }

# # Create an AKS instance
# resource "azurerm_kubernetes_cluster" "aks" {
#   name                = "OZAKSCluster"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   dns_prefix          = "oz-aks"

#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_D2_v2"
#   }

#   identity {
#     type = "SystemAssigned"
#   }
# }

######## Azure database for MySQL ########

# resource "azurerm_mysql_server" "oz-mysql" {
#   name                = "oz-mysql"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   sku_name            = "B_Gen5_1"
#   version             = "5.7"
#   storage_profile {
#     storage_mb            = 5120
#     backup_retention_days = 7
#     geo_redundant_backup  = "Disabled"
#   }
#   administrator_login          = "mysqladminun"
#   administrator_login_password = "dbxadminpw*"
#   ssl_enforcement_enabled      = false
# }

# resource "azurerm_mysql_database" "oz-db" {
#   name                = "oz-database"
#   resource_group_name = azurerm_resource_group.rg.name
#   server_name         = azurerm_mysql_server.oz-mysql.name
#   charset             = "utf8"
#   collation           = "utf8_unicode_ci"
# }