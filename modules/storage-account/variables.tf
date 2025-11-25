variable "name" {
  description = "Name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the storage account will be created"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type"
  type        = string
  default     = "LRS"
}

variable "access_tier" {
  description = "Access tier for Blob storage"
  type        = string
  default     = "Hot"
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed"
  type        = bool
  default     = true
}

variable "containers" {
  description = "Map of storage containers to create"
  type = map(object({
    access_type = optional(string, "blob")
  }))
  default = {}
}

variable "static_website" {
  description = "Static website configuration"
  type = object({
    index_document = string
    error_document = string
  })
  default = null
}

variable "tags" {
  description = "Tags to apply to the storage resources"
  type        = map(string)
  default     = {}
}

