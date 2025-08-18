output "acr_login_server" {
  description = "The login server of the ACR"
  value       = azurerm_container_registry.this.login_server
}
