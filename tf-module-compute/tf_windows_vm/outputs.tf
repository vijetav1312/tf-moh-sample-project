output "windows_vm_id" {
  description = "The ID of the Windows VM"
  value       = azurerm_windows_virtual_machine.this.id
}

output "windows_vm_public_ip" {
  description = "The public IP of the Windows VM"
  value       = azurerm_public_ip.this.ip_address
}

output "windows_vm_nic_id" {
  description = "The NIC ID of the Windows VM"
  value       = azurerm_network_interface.this.id
}
