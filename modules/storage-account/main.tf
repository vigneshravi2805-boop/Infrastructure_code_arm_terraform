resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier
  min_tls_version          = "TLS1_2"
  https_traffic_only_enabled    = true
  public_network_access_enabled = var.public_network_access_enabled
  allow_nested_items_to_be_public = false
  tags                    = var.tags

  identity {
    type = "SystemAssigned"
  }

  dynamic "static_website" {
    for_each = var.static_website == null ? [] : [var.static_website]
    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_document
    }
  }
}

resource "azurerm_storage_container" "this" {
  for_each              = var.containers
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = lookup(each.value, "access_type", "private")
}

