# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

#Crea grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "EastUS"
  tags = {
    Environment = "Terraform Getting Started"
    Team        = "Axity"
  }
}

# Crea data Factory
resource "azurerm_data_factory" "DFantonio" {
  name                = "DFpruebaantonioaxity"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Modulo blob storage
module "blob-storage" {
  source = "./modules/blob-storage"

  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

# Modulo SQL
module "sql-database" {
  source = "./modules/database"

  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  username = var.username
  password = var.password
}