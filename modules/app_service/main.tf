resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.name}-${var.resource_group_name}-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id

  site_config {
    application_stack {
      docker_image_name   = var.image
      docker_registry_url = "https://${var.acr_login_server}"
    }
  }

  app_settings = {
    "WEBSITES_PORT"                  = var.port
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${var.acr_login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.acr_admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.acr_admin_password
  }
}