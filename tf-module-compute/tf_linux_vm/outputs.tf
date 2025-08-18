output "linux_vm_id" {
  description = "The ID of the Linux VM"
  value       = azurerm_linux_virtual_machine.this.id
}

output "linux_vm_public_ip" {
  description = "The public IP of the Linux VM"
  value       = azurerm_public_ip.this.ip_address
}

output "linux_vm_nic_id" {
  description = "The NIC ID of the Linux VM"
  value       = azurerm_network_interface.this.id
}
