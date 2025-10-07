#  Resource Group
variable "microservicesRgJenniferCastro" {
  type        = string
  description = "Resource group name"
  default     = "microservicesRgJenniferCastro"
}

#  Azure Region
variable "microservicesLocationJenniferCastro" {
  type        = string
  description = "Azure region where resources will be deployed"
  default     = "eastus"
}

#  Azure Container Registry
variable "microservicesAcrJenniferCastro" {
  type        = string
  description = "Azure Container Registry name"
  default     = "microservicesAcrJenniferCastro"
}

#  Azure API Management
variable "microservicesApimJenniferCastro" {
  type        = string
  description = "API Management service name"
  default     = "microservicesApimJenniferCastro"
}

#  API Management Publisher Name
variable "microservicesApimPublisherNameJenniferCastro" {
  type        = string
  description = "Name of the publisher for API Management"
  default     = "Jennifer Castro"
}

#  API Management Publisher Email
variable "microservicesApimPublisherEmailJenniferCastro" {
  type        = string
  description = "Publisher email contact for API Management"
  default     = "1111540677@u.icesi.edu.co"
}

#  Azure Container Instances (ACI)
variable "microservicesAciJenniferCastro" {
  type        = string
  description = "Container Group name for microservices deployment"
  default     = "microservicesAciJenniferCastro"
}

