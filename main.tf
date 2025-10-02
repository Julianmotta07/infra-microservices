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

# 3. Network (opcional, para aislar microservicios)
module "network" {
  source   = "./modules/network"
  rg_name  = module.rg.name
  location = var.location
  vnet_name = var.vnet_name
  subnet_names = ["frontend", "backend"]
}

# 4. Azure Container Instances (5 contenedores)
module "aci" {
  source        = "./modules/aci"
  rg_name       = module.rg.name
  location      = var.location
  acr_login     = module.acr.login_server
  acr_username  = module.acr.admin_username
  acr_password  = module.acr.admin_password
  frontend_ip   = true   # solo el frontend es público

  containers = [
    {
      name   = "frontend"
      image  = "${module.acr.login_server}/frontend:latest"
      subnet = module.network.subnet_ids["frontend"]
      public = true
    },
    {
      name   = "auth-api"
      image  = "${module.acr.login_server}/auth-api:latest"
      subnet = module.network.subnet_ids["backend"]
      public = false
    },
    {
      name   = "todos-api"
      image  = "${module.acr.login_server}/todos-api:latest"
      subnet = module.network.subnet_ids["backend"]
      public = false
    },
    {
      name   = "log-message-processor"
      image  = "${module.acr.login_server}/log-message-processor:latest"
      subnet = module.network.subnet_ids["backend"]
      public = false
    },
    {
      name   = "users-api"
      image  = "${module.acr.login_server}/users-api:latest"
      subnet = module.network.subnet_ids["backend"]
      public = false
    }
  ]
}
