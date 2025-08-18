
variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "rg_location" {
  description = "The location of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the VM will be placed"
  type        = string
}

variable "vm_name" {
  description = "The name of the Windows virtual machine"
  type        = string
}

variable "username" {
  description = "Admin username for the VM"
  type        = string
}

variable "password" {
  description = "Admin password for the Windows VM"
  type        = string
  sensitive   = true
}
