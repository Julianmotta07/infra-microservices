# Outputs
output "fqdn" {
  value       = azurerm_container_group.microservices.fqdn
  description = "FQDN del frontend"
}

output "frontend_url" {
  value       = "http://${azurerm_container_group.microservices.fqdn}:8080"
  description = "URL completa del frontend"
}

output "ip_address" {
  value       = azurerm_container_group.microservices.ip_address
  description = "IP pública"
}