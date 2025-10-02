resource "azurerm_container_group" "containers" {
  for_each            = { for c in var.containers : c.name => c }
  name                = each.value.name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"

  image_registry_credential {
    server   = var.acr_login
    username = var.acr_username
    password = var.acr_password
  }

  container {
    name   = each.value.name
    image  = each.value.image
    cpu    = 1
    memory = 1.5

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  ip_address_type = each.value.public ? "Public" : "Private"
  dns_name_label  = each.value.public ? "${each.value.name}-dns" : null

  subnet_ids      = each.value.public ? null : [each.value.subnet]
}


