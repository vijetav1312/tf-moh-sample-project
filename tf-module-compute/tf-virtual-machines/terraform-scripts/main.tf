
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name_prefix != "" ? "${var.resource_group_name_prefix}-${var.resource_group_name}" : var.resource_group_name
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

##########################
# Windows VM Components
##########################

# Create public IPs
resource "azurerm_public_ip" "tf_moh_catalog_public_ip" {
  name                = "catalog-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}



# Create network interface
resource "azurerm_network_interface" "tf_moh_catalog_nic" {
  name                = "catalog-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "catalog_nic_configuration"
    subnet_id                     = azurerm_subnet.tf_moh_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf_moh_catalog_public_ip.id
  }
}


# Create virtual machine
resource "azurerm_windows_virtual_machine" "tf_moh_catalog_vm" {
  name                  = "catalog-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.tf_moh_catalog_nic.id]
  size                  = "Standard_B2ms"
  

 os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-windows"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "windowsserver"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  computer_name  = "winserver2022"
  provision_vm_agent = true
  admin_username = var.username
  admin_password = var.password


}

# Network Security Group
resource "azurerm_network_security_group" "tf_moh_catalog_nsg" {
  name                = "catalog-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Attach NSG to NIC
resource "azurerm_network_interface_security_group_association" "tf_moh_catalog_nic_nsg" {
  network_interface_id      = azurerm_network_interface.tf_moh_catalog_nic.id
  network_security_group_id = azurerm_network_security_group.tf_moh_catalog_nsg.id

}


##########################
# Linux VM Components
##########################


# Create public IPs
resource "azurerm_public_ip" "tf_moh_weather_public_ip" {
name = "wheather-public-ip"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
allocation_method = "Static"
sku = "Standard"
}


# Create network interface
resource "azurerm_network_interface" "tf_moh_weather_nic" {
name = "wheather-nic"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name

ip_configuration {
name = "wheather_nic_configuration"
subnet_id = azurerm_subnet.tf_moh_subnet.id
private_ip_address_allocation = "Dynamic"
public_ip_address_id = azurerm_public_ip.tf_moh_weather_public_ip.id
}
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "tf_moh_weather_vm" {
name = "weather-vm"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
network_interface_ids = [azurerm_network_interface.tf_moh_weather_nic.id]
size = "Standard_B2ms"


os_disk {
caching = "ReadWrite"
storage_account_type = "Standard_LRS"
name = "osdisk-linux"
}

source_image_reference {
publisher = "Canonical"
offer = "00001-com-ubuntu-server-jammy"
sku = "22_04-lts-gen2"
version = "latest"
}

admin_username = var.username

admin_ssh_key {
username = var.username
public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
}
computer_name       = "linuxvm"
provision_vm_agent  = true
}

# Network Security Group
resource "azurerm_network_security_group" "tf_moh_weather_nsg" {
name = "catalog-nsg"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name

security_rule {
name = "AllowSSH"
priority = 1001
direction = "Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range = "22"
source_address_prefix = "*"
destination_address_prefix = "*"
}

security_rule {
name = "AllowHTTP"
priority = 1002
direction = "Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range = "80"
source_address_prefix = "*"
destination_address_prefix = "*"
}
}

# Attach NSG to NIC
resource "azurerm_network_interface_security_group_association" "tf_moh_weather_nic_nsg" {
network_interface_id = azurerm_network_interface.tf_moh_weather_nic.id
network_security_group_id = azurerm_network_security_group.tf_moh_weather_nsg.id

}

