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

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Make client_id, tenant_id, subscription_id and object_id variables
data "azurerm_client_config" "current" {}
