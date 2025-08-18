
output "windows_vm_ip" {
  value = module.windows_vm.windows_vm_public_ip
}

output "linux_vm_ip" {
  value = module.linux_vm.linux_vm_public_ip
}

output "inventory_webapp_id" {
  description = "The resource ID of the inventory Web App"
  value       = module.appservice.app_service_id
}

output "inventory_appservice_plan_id" {
  description = "The ID of the App Service Plan"
  value       = module.appservice.app_service_plan_id
}

# Outputs from App Service Module
output "inventory_webapp_url" {
  description = "The default URL of the inventory Web App"
  value       = module.appservice.app_service_default_hostname
}