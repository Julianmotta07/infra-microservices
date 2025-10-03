# modules/aci/main.tf
# Container Group con TODOS los microservicios compartiendo localhost

resource "azurerm_container_group" "microservices" {
  name                = "microservices-group"
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = "microservices-${substr(md5(var.rg_name), 0, 8)}"

  # REDIS - Necesario para todos-api y log-message-processor
  container {
    name   = "redis"
    image  = "${var.acr_login}/redis:7"
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 6379
      protocol = "TCP"
    }
  }

  # AUTH API - Puerto 8000
  container {
    name   = "auth-api"
    image  = "${var.acr_login}/auth-api:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 8000
      protocol = "TCP"
    }

    environment_variables = {
      AUTH_API_PORT      = "8000"
      USERS_API_ADDRESS  = "http://127.0.0.1:8083"  # Cambiado a localhost!
      JWT_SECRET         = "PRFT"
    }
  }

  # USERS API - Puerto 8083
  container {
    name   = "users-api"
    image  = "${var.acr_login}/users-api:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 8083
      protocol = "TCP"
    }

    environment_variables = {
      JWT_SECRET  = "PRFT"
      SERVER_PORT = "8083"
    }
  }

  # TODOS API - Puerto 8082
  container {
    name   = "todos-api"
    image  = "${var.acr_login}/todos-api:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 8082
      protocol = "TCP"
    }

    environment_variables = {
      TODO_API_PORT = "8082"
      JWT_SECRET    = "PRFT"
      REDIS_HOST    = "127.0.0.1"  # Cambiado a localhost!
      REDIS_PORT    = "6379"
      REDIS_CHANNEL = "log_channel"
    }
  }

  # LOG MESSAGE PROCESSOR
  container {
    name   = "log-message-processor"
    image  = "${var.acr_login}/log-message-processor:latest"
    cpu    = "0.5"
    memory = "0.5"

    environment_variables = {
      REDIS_HOST    = "127.0.0.1"  # Cambiado a localhost!
      REDIS_PORT    = "6379"
      REDIS_CHANNEL = "log_channel"
    }
  }

  # FRONTEND - Puerto público 8080
  container {
    name   = "frontend"
    image  = "${var.acr_login}/frontend:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables = {
      PORT              = "8080"
      AUTH_API_ADDRESS  = "http://127.0.0.1:8000"  # Cambiado a localhost!
      TODOS_API_ADDRESS = "http://127.0.0.1:8082"  # Cambiado a localhost!
    }
  }

  # Credenciales del ACR
  image_registry_credential {
    server   = var.acr_login
    username = var.acr_username
    password = var.acr_password
  }

  tags = {
    environment = "development"
    project     = "taller-universitario"
  }
}

