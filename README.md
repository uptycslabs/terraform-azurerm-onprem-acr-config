# terraform-azurerm-onprem-acr-config

This module creates the necessary Azure resources to grant uptycs access to Azure Container Registries for registry monitoring. Access is setup with a custom Application and service principals.

This terraform module will create the following resources:

- Application
- Service principal

In addition to these resources, the newly created service principal will have the following permissions granted to it:
- Microsoft.ContainerRegistry/registries/read
- Microsoft.ContainerRegistry/registries/pull/read

And will be granted the following roles:
- Reader
- AcrPull

## Prerequisites

Ensure you have the following privileges before you execute the Terraform Script:
* Administrative roles:
  * Global administrator

## Authentication

To authenticate Azure tenant, use the following command:

```
$ az login
```

## Terraform Script

To execute the Terraform script:

1. **Prepare .tf file**

Create a `main.tf` file in a new folder. Copy and paste the following configuration and modify as required:

```hcl
module "acr-config" {
  source            = "uptycslabs/onprem-acr-config/azurerm"

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

```

2. **Init, Plan and Apply**

**Inputs**

| Name                 | Description                                              | Type     | Default     |
| ---------------------| -------------------------------------------------------- | -------- | ----------- |
| uptycs_app_client_id | The Client ID of Uptycs multi-tenant app                 | `string` |             |
| resource_name        | A unique prefix for the resources created by this module | `string` | "uptycs_custom_role" |     

### Outputs

| Name          | Description   |
| ------------- | ------------- |
| tenant_id     | Tenant ID     |
| client_id     | Client ID     |
| client_secret | Client Secret |

```
$ terraform init --upgrade
$ terraform plan  # Please verify before applying
$ terraform apply
# Wait until successfully completed
$ terraform output -raw 'client_secret'
```
