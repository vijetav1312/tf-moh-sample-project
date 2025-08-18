resource "azurerm_public_ip" "this" {
  name                = "${var.vm_name}-public-ip"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "this" {
  name                = "${var.vm_name}-nic"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_windows_virtual_machine" "this" {
  name                  = var.vm_name
  location              = var.rg_location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.this.id]
  size                  = "Standard_B2ms"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.vm_name}-osdisk"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "windowsserver"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  computer_name    = var.vm_name
  admin_username   = var.username
  admin_password   = var.password
  provision_vm_agent = true
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.vm_name}-nsg"
  location            = var.rg_location
  resource_group_name = var.rg_name

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

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}
