resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.rg_name
  publisher_name      = var.apim_publisher_name
  publisher_email     = var.apim_publisher_email
  sku_name            = "Consumption_0" # plan gratuito para pruebas

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_api_management_api" "frontend_api" {
  name                = "frontend-api"
  resource_group_name = var.rg_name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Frontend API"
  path                = "frontend"
  protocols           = ["https"]

  service_url = "http://frontend"
}


output "apim_name" {
  value = azurerm_api_management.apim.name
}

output "apim_id" {
  value = azurerm_api_management.apim.id
}

