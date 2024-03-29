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

resource "azurecaf_name" "plan_name" {
  name          = var.resource_token
  resource_type = "azurerm_app_service_plan"
  random_length = 0
  clean_input   = true
}

resource "azurerm_service_plan" "plan" {
  name                = azurecaf_name.plan_name.result
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = var.os_type
  sku_name            = var.sku_name
  tags                = local.tags
}
