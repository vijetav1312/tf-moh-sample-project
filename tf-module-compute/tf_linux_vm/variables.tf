variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "rg_location" {
  description = "The location of the resource group"
  type        = string
}
variable "rg_id" {
  description = "The location of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the VM will be placed"
  type        = string
}

variable "vm_name" {
  description = "The name of the Linux virtual machine"
  type        = string
}

variable "username" {
  description = "Admin username for the Linux VM"
  type        = string
}

variable "ssh_key" {
  description = "Public SSH key for the Linux VM"
  type        = string
}
