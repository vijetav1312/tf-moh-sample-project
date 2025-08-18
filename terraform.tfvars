resource_group_name         = "readit-app"
location                    = "westeurope"
inventory_service_plan_name = "asp-inventory"
invertory_service_name      = "app-inventory"
inventory_app_settings = {
  WEBSITE_RUN_FROM_PACKAGE = "1"
  CUSTOM_SETTING           = "value"
}