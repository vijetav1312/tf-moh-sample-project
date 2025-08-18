module "resource_group" {
  source              = "./tf_resource_group"
  resource_group_name_prefix = var.resource_group_name_prefix
  resource_group_location = var.location
  resource_group_name = var.resource_group_name
}

# App Service Module
module "appservice" {
  source = "./tf-module-compute/tf_app_services"

  inventory_service_plan_name = var.inventory_service_plan_name
  invertory_service_name      = var.invertory_service_name
  inventory_app_settings      = var.inventory_app_settings

  # Pass RG outputs to child
  rg_name     = module.resource_group.rg_name
  rg_location = module.resource_group.rg_location
}


# Virtual Network Module (if you split subnet too)
module "network" {
  source              = "./tf_vnet"
   # Pass RG outputs to child
  rg_name     = module.resource_group.rg_name
  rg_location = module.resource_group.rg_location

}

# Windows VM
module "windows_vm" {
  source     = "./tf-module-compute/tf_windows_vm"
  rg_name    = module.resource_group.rg_name
  rg_location= module.resource_group.rg_location
  subnet_id   = module.network.subnet_id
  vm_name    = "catalog-vm"
  username   = var.windows_admin_username
  password   = var.windows_admin_password
}

# Linux VM
module "linux_vm" {
  source     = "./tf-module-compute/tf_linux_vm"
  rg_name    = module.resource_group.rg_name
  rg_location= module.resource_group.rg_location
  subnet_id   = module.network.subnet_id
  vm_name    = "weather-vm"
  username   = var.linux_admin_username
  ssh_key    = ""
  rg_id = module.resource_group.rg_id

  

}

module "acr" {

  source = "./tf-module-compute/tf-acr" 
  rg_name = module.resource_group.rg_name
  acr_name            = "readitregistry"
  rg_location            = module.resource_group.rg_location
  sku                 = "Basic"
  admin_enabled       = true
  rg_id = module.resource_group.rg_id

}