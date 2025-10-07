variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "apim_name" {
  type        = string
  description = "Name of the API Management service"
}

variable "apim_publisher_name" {
  type        = string
  description = "Publisher name for the API Management service"
}

variable "apim_publisher_email" {
  type        = string
  description = "Publisher contact email for the API Management service"
}
