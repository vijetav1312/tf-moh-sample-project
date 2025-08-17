output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "catalog_vm_public_ip" {
  value = azurerm_public_ip.tf_moh_catalog_public_ip.ip_address
}

output "weather_vm_public_ip" {
  value = azurerm_public_ip.tf_moh_weather_public_ip.ip_address
}