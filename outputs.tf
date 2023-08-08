/*
 * Copyright (c) 2023 Uptycs, Inc. All rights reserved
 */

output "tenant_id" {
  description = "Tenant ID associated with the service principal, please update this back in Uptycs' UI"
  value       = data.azurerm_client_config.current.tenant_id
}

output "client_id" {
  description = "Client ID associated with the service principal, please update this back in Uptycs' UI"
  value       = azuread_application.UptycsRegistryScanner.application_id
}

output "client_secret" {
  description = "Client Secret associated with the generated application, please update this back in Uptycs' UI"
  value       = azuread_application_password.UptycsRegistryScannerSecret.value
}
