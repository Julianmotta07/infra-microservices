variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "acr_name" {
  description = "Nombre del Azure Container Registry"
  type        = string
}

variable "microservices" {
  description = "Lista de microservicios con nombre, imagen y puerto"
  type = list(object({
    name  = string
    image = string
    port  = number
  }))
}

variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
}