provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Get common tags
locals {
  common_tags = merge(
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

# Resource Group Module
module "resource_group" {
  source = "../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

# Virtual Network Module
module "vnet" {
  source = "../modules/vnet"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  vnet_name           = "${var.project_name}-vnet"
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = local.common_tags
}

# Storage Account Module
module "storage_account" {
  source = "../modules/storage-account"

  name                          = var.storage_account.name
  resource_group_name           = module.resource_group.resource_group_name
  location                      = module.resource_group.location
  account_tier                  = try(var.storage_account.account_tier, "Standard")
  account_replication_type      = try(var.storage_account.account_replication_type, "LRS")
  access_tier                   = try(var.storage_account.access_tier, "Hot")
  public_network_access_enabled = try(var.storage_account.public_network_access_enabled, true)
  static_website                = try(var.storage_account.static_website, null)
  containers                    = var.storage_containers
  tags                          = local.common_tags
}

