module "acr-config" {
  source            = "uptycslabs/acr-config/azurerm"

  uptycs_app_client_id = "Copy/Paste From the Uptycs UI"
  root_management_group_id = "The id of the root management group"
}


