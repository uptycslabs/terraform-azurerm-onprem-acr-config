/*
 * Copyright (c) 2023 Uptycs, Inc. All rights reserved
 */

# Get MSGraph App
resource "azuread_service_principal" "msgraph" {
  application_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing   = true
}

# Create a service principal for the Uptycs App
resource "azuread_service_principal" "service_principal" {
  application_id = var.uptycs_app_client_id
  use_existing   = true
}

# Create Graph API related permissions to the service principal
resource "azuread_app_role_assignment" "uptycs_registry_reader_role" {
  app_role_id         = azuread_service_principal.msgraph.app_role_ids["Application.Read.All"]
  principal_object_id = azuread_service_principal.service_principal.object_id
  resource_object_id  = azuread_service_principal.msgraph.object_id
}

resource "azurerm_role_definition" "Define_Uptycs_Registry_Reader_Role" {
  name        = "UptycsRegistryReader"
  scope       = data.azurerm_management_group.parent_management_group.id
  description = "Read permissions for accessing ACR"

  permissions {
    actions = ["Microsoft.ContainerRegistry/registries/pull/read"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_management_group.parent_management_group.id,
  ]
}
