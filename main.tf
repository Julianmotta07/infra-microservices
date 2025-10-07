provider "azurerm" {
  features {}
}

# 1. Resource Group
module "rg" {
  source   = "./modules/resource_group"
  rg_name  = var.rg_name
  location = var.location
}

# 2. Azure Container Registry
module "acr" {
  source   = "./modules/acr"
  rg_name  = module.rg.name
  location = var.location
  acr_name = var.acr_name
}

# 3. Azure Container Instances (TODOS en un solo grupo + Redis)
module "aci" {
  source       = "./modules/aci"
  rg_name      = module.rg.name
  location     = var.location
  acr_login    = module.acr.login_server
  acr_username = module.acr.admin_username
  acr_password = module.acr.admin_password
}

# 4. API Management (Gateway)
module "apim" {
  source               = "./modules/apim"
  rg_name              = module.rg.name
  location             = var.location
  apim_name            = var.apim_name
  apim_publisher_name  = var.apim_publisher_name
  apim_publisher_email = var.apim_publisher_email
}

