resource_group_name = "my-microservices-rg"
location            = "East US"
acr_name            = "mymicroservicesacr"

microservices = [
  { name = "auth-api",      image = "microservice-app-example-auth-api:latest",      port = 8000 },
  { name = "users-api",     image = "microservice-app-example-users-api:latest",     port = 8083 },
  { name = "todos-api",     image = "microservice-app-example-todos-api:latest",     port = 8082 },
  { name = "frontend",      image = "microservice-app-example-frontend:latest",      port = 8080 },
  { name = "log-processor", image = "microservice-app-example-log-message-processor:latest", port = 5000 }
]