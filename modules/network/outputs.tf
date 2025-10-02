output "subnet_ids" {
  value = { for idx, name in var.subnet_names : name => azurerm_subnet.subnets[idx].id }
}