output "account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_web_endpoint" {
  description = "Static website endpoint (if enabled)"
  value       = azurerm_storage_account.this.primary_web_endpoint
}

output "containers" {
  description = "Map of container names to IDs"
  value       = { for k, c in azurerm_storage_container.this : k => c.id }
}

