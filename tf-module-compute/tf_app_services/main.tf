resource "azurerm_service_plan" "moh_appservice_plan" {
  name                = var.inventory_service_plan_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  os_type             = "Windows"
  sku_name            = "F1" # Free Tier
}

resource "azurerm_windows_web_app" "moh_appservice" {
  name                = "${var.invertory_service_name}-${random_integer.suffix.result}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.moh_appservice_plan.id

  site_config {
    always_on = false # Not supported on F1, but good practice to keep explicit
  }

  app_settings = var.inventory_app_settings
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}
output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_service_plan.moh_appservice_plan.id
}

output "app_service_id" {
  description = "The ID of the App Service"
  value       = azurerm_windows_web_app.moh_appservice.id
}

output "app_service_name" {
  description = "The name of the App Service"
  value       = azurerm_windows_web_app.moh_appservice.name
}

output "app_service_default_hostname" {
  description = "The default hostname of the App Service"
  value       = azurerm_windows_web_app.moh_appservice.default_hostname
}