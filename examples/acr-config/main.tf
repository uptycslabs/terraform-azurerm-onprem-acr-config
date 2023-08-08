module "acr-config" {
  source            = "uptycslabs/onprem-acr-config/azurerm"

  # Note that the following resource name is optional. You may specify this to
  # customize the name of the generated azurerm_role_definition.
  resource_name = "AnExampleName"
}

output "tenant_id" {
  value = module.acr-config.tenant_id
}

output "client_id" {
  value = module.acr-config.client_id
}

output "client_secret" {
  value     = module.acr-config.client_secret
  sensitive = true
}
