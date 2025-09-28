variable "name" {
  description = "Nombre del microservicio"
  type        = string
}

variable "image" {
  description = "Nombre de la imagen Docker en ACR"
  type        = string
}

variable "port" {
  description = "Puerto del microservicio"
  type        = number
}

variable "resource_group_name" {
  description = "Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "acr_login_server" {
  description = "Login server del Azure Container Registry"
  type        = string
}

variable "acr_admin_username" {
  description = "Usuario administrador del ACR"
  type        = string
}

variable "acr_admin_password" {
  description = "Password administrador del ACR"
  type        = string
  sensitive   = true
}

variable "service_plan_id" {
  description = "ID del App Service Plan compartido"
  type        = string
}