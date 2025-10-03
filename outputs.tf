output "frontend_url" {
  value       = module.aci.frontend_url
  description = "URL completa del frontend (incluye puerto 8080)"
}

output "ip_address" {
  value       = module.aci.ip_address
  description = "IP pública del Container Group"
}

output "fqdn" {
  value       = module.aci.fqdn
  description = "FQDN completo"
}