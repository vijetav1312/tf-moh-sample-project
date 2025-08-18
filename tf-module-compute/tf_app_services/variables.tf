variable "inventory_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "invertory_service_name" {
  description = "Base name for the Web App (a random suffix will be appended)"
  type        = string
}

variable "inventory_app_settings" {
  description = "App settings for the Web App"
  type        = map(string)
  default     = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}

variable "rg_name" {
  description = "Name of the Resource Group (from parent module)"
  type        = string
}

variable "rg_location" {
  description = "Location of the Resource Group (from parent module)"
  type        = string
}