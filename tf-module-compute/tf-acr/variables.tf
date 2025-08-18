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

variable "acr_name" {
  description = "The name of the Azure Container Registry (must be globally unique)"
  type        = string
}

variable "sku" {
  description = "The SKU of the ACR"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable the admin account for ACR"
  type        = bool
  default     = true
}