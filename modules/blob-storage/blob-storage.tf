variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
}

resource "azurerm_storage_account" "antonioaxity-demo" {
    name = "antonioaxity"
    resource_group_name = var.resource_group_name
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"

    tags = {
        creator = "Terraform"
        project = "terraform-demo"
    }
}

resource "azurerm_storage_container" "antonioaxity-demo" {
  name                  = "terraform-demo"
  storage_account_name  = azurerm_storage_account.antonioaxity-demo.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "IMDB-projects" {
  name                   = "movies_AMAZON.csv"
  storage_account_name   = azurerm_storage_account.antonioaxity-demo.name
  storage_container_name = azurerm_storage_container.antonioaxity-demo.name
  type                   = "Block"
  source                 = "./data-factory-datasets/movies_AMAZON.csv"

  metadata = {
        creator = "Terraform"
        project = "terraform-demo"
  }
}