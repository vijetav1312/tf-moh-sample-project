# Create virtual network
resource "azurerm_virtual_network" "tf_moh_network" {
  name                = "readit-app-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.rg_location
  resource_group_name = var.rg_name
 
}

# Create subnet
resource "azurerm_subnet" "tf_moh_subnet" {
  name                 = "readit-app-subnet"
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_moh_network.name
  address_prefixes     = ["10.0.1.0/24"]
}



output "subnet_id" {
  value = azurerm_subnet.tf_moh_subnet.id
}
