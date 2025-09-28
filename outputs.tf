output "app_services_urls" {
  value = { for k, v in module.microservices : k => v.app_hostname }
}