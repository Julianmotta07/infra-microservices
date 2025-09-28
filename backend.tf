terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatejm07"
    container_name       = "tfstate"
    key                  = "infra.terraform.tfstate"
  }
}