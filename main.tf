/*
 * Copyright (c) 2023 Uptycs, Inc. All rights reserved
 */

resource "azuread_application" "UptycsRegistryScanner" {
  display_name = "UptycsRegistryScanner-${var.resource_name}"
  owners       = [data.azurerm_client_config.current.object_id]
}

resource "azuread_application_password" "UptycsRegistryScannerSecret" {
  application_object_id = azuread_application.UptycsRegistryScanner.id
  display_name = "UptycsRegistryScanner-${var.resource_name}"
}

# Create a service principal for the Uptycs App
resource "azuread_service_principal" "service_principal" {
  application_id = azuread_application.UptycsRegistryScanner.application_id
  use_existing   = true
}

resource "azurerm_role_definition" "Define_Uptycs_Registry_Reader_Role" {
  name        = var.resource_name
  scope       = data.azurerm_subscription.current.id
  description = "Read permissions for accessing ACR"

  permissions {
    actions = [
      "Microsoft.ContainerRegistry/registries/read",
      "Microsoft.ContainerRegistry/registries/pull/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id,
  ]
}

# Give the service principal a Reader role in the Subscription
resource "azurerm_role_assignment" "attach_reader_role" {
  principal_id         = azuread_service_principal.service_principal.id
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Reader"
}

# Give the service principal an AcrPull role in the Subscription
resource "azurerm_role_assignment" "attach_acrpull_role" {
  principal_id         = azuread_service_principal.service_principal.id
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "AcrPull"
}

resource "azurerm_role_assignment" "attach_custom_role" {
  principal_id       = azuread_service_principal.service_principal.id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.Define_Uptycs_Registry_Reader_Role.role_definition_resource_id
}
