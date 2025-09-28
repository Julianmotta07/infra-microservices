# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Service Plan compartido
resource "azurerm_service_plan" "shared_plan" {
  name                = "${var.resource_group_name}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Login a ACR
resource "null_resource" "docker_login" {
  provisioner "local-exec" {
    command = "az acr login --name ${azurerm_container_registry.acr.name}"
  }
}

# Push de imágenes al ACR
resource "null_resource" "push_images" {
  count = length(var.microservices)

  triggers = {
    image = var.microservices[count.index].image
  }

  depends_on = [null_resource.docker_login]

  provisioner "local-exec" {
    command = <<EOT
      docker tag ${var.microservices[count.index].image} ${azurerm_container_registry.acr.login_server}/${var.microservices[count.index].image}
      docker push ${azurerm_container_registry.acr.login_server}/${var.microservices[count.index].image}
    EOT
  }
}

# Desplegar microservicios usando módulo
module "microservices" {
  source = "./modules/app_service"
  for_each = { for ms in var.microservices : ms.name => ms }

  name                = each.value.name
  image               = each.value.image
  port                = each.value.port
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  acr_login_server    = azurerm_container_registry.acr.login_server
  acr_admin_username  = azurerm_container_registry.acr.admin_username
  acr_admin_password  = azurerm_container_registry.acr.admin_password
  service_plan_id     = azurerm_service_plan.shared_plan.id
}