variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "acr_login" {
  type        = string
  description = "ACR login server"
}

variable "acr_username" {
  type        = string
  description = "ACR admin username"
}

variable "acr_password" {
  type        = string
  description = "ACR admin password"
  sensitive   = true
}

variable "containers" {
  description = "List of container definitions (name, image, subnet, public)"
  type = list(object({
    name   = string
    image  = string
    subnet = string
    public = bool
  }))
}

variable "frontend_ip" {
  type        = bool
  description = "Whether to expose the container publicly (frontend)"
  default     = false
}
