# 🔹 Resource Group
variable "rg_name" {
  type        = string
  description = "Resource group name"
  default     = "microservicesRgJenniferCastro"
}

# 🔹 Azure Region
variable "location" {
  type        = string
  description = "Azure region for all resources"
  default     = "eastus"
}

# 🔹 Azure Container Registry
variable "acr_name" {
  type        = string
  description = "Azure Container Registry name"
  default     = "microservicesacrjennifercastro"
}

# 🔹 API Management (APIM)
variable "apim_name" {
  type        = string
  description = "API Management service name"
  default     = "microservicesApimJenniferCastro"
}

variable "apim_publisher_name" {
  type        = string
  description = "Name of the publisher for API Management"
  default     = "Jennifer Castro"
}

variable "apim_publisher_email" {
  type        = string
  description = "Publisher email contact for API Management"
  default     = "jennifer.castro@example.com"
}
