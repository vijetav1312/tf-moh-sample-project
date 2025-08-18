
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name_prefix != "" ? "${var.resource_group_name_prefix}-${var.resource_group_name}" : var.resource_group_name  
  location = var.resource_group_location
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_location" {
  value = azurerm_resource_group.rg.location
}
output "rg_id" {
  value = azurerm_resource_group.rg.id
}

# Create virtual network
resource "azurerm_virtual_network" "tf_moh_network" {
  name                = "readit-app-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "tf_moh_subnet" {
  name                 = "readit-app-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.tf_moh_network.name
  address_prefixes     = ["10.0.1.0/24"]
}



output "subnet_id" {
  value = azurerm_subnet.tf_moh_subnet.id
}
