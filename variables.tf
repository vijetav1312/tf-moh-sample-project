variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region for the Resource Group"
  default     = "westeurope"
}

variable "inventory_service_plan_name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "invertory_service_name" {
  type        = string
  description = "Base name for the Web App"
}

variable "inventory_app_settings" {
  type        = map(string)
  description = "App settings for the Web App"
  default = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
variable "resource_group_name_prefix" {
  type        = string
  description = "Azure region for the Resource Group"
  default     = "rg"
}

# Windows VM variables
variable "windows_vm_name" {
  description = "Name of the Windows VM"
  type        = string
  default     = "catalog-vm"
}

variable "windows_admin_username" {
  description = "Admin username for Windows VM"
  type        = string
  default = "azureadmin"
}

variable "windows_admin_password" {
  description = "Admin password for Windows VM"
  type        = string
  sensitive   = true
  default = "P@ssword1234!"
}

# Linux VM variables
variable "linux_vm_name" {
  description = "Name of the Linux VM"
  type        = string
  default     = "weather-vm"
}

variable "linux_admin_username" {
  description = "Admin username for Linux VM"
  type        = string
  default = "azureadmin"
}


variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = "readit-subnet"
}