terraform {
  required_version = ">= 0.13.1"
  required_providers {
    azurerm = {
      version = ">= 3.18.0"
      source  = "hashicorp/azurerm"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = ">= 1.2.15"
    }
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)
}

resource "azurecaf_name" "applicationinsights_name" {
  name          = var.resource_token
  resource_type = "azurerm_application_insights"
  random_length = 0
  clean_input   = true
}

resource "azurerm_application_insights" "applicationinsights" {
  name                = azurecaf_name.applicationinsights_name.result
  location            = var.location
  resource_group_name = var.rg_name
  application_type    = "web"
  workspace_id        = var.workspace_id
  tags                = local.tags
}
