output "resource_group_name" {
  description = "Name of the created resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = module.resource_group.resource_group_id
}

output "vnet_id" {
  description = "ID of the created virtual network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "Name of the created virtual network"
  value       = module.vnet.vnet_name
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value       = module.vnet.subnet_ids
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.account_name
}

output "storage_container_ids" {
  description = "Map of storage container IDs"
  value       = module.storage_account.containers
}

