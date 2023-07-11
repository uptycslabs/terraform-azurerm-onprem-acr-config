/*
 * Copyright (c) 2023 Uptycs, Inc. All rights reserved
 */

data "azuread_application_published_app_ids" "well_known" {}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
