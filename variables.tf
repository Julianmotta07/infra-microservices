variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "acr_name" {
  type        = string
  description = "Azure Container Registry name"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
}

variable "subnet_names" {
  type        = list(string)
  description = "List of subnet names"
  default     = ["frontend", "backend"]
}
