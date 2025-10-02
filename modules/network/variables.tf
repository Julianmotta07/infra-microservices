variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Vnet name"
}
variable "subnet_names" {
  type        = list(string)
  description = "subnet names"
}

