resource "azurerm_container_registry" "this" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
}