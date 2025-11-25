variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default = "rg-azure-training-dev"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "azure-training"
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

# VNet Variables
variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    address_prefixes = list(string)
    service_endpoints = optional(list(string), [])
  }))
  default = {
    subnet1 = {
      address_prefixes = ["10.0.1.0/24"]
      service_endpoints = []
    }
  }
}

# Storage Account configuration
variable "storage_account" {
  description = "Storage account configuration"
  type = object({
    name                          = string
    account_tier                  = optional(string, "Standard")
    account_replication_type      = optional(string, "LRS")
    access_tier                   = optional(string, "Hot")
    public_network_access_enabled = optional(bool, true)
    static_website = optional(object({
      index_document = string
      error_document = string
    }))
  })
  default = {
    name = "stdevtrainingtesthe"
    static_website = {
      index_document = "index.html"
      error_document = "index.html"
    }
  }
}

variable "storage_containers" {
  description = "Containers to provision in the storage account"
  type = map(object({
    access_type = optional(string, "private") # default private
  }))
  default = {
    appassets = {
      access_type = "private"
    }
  }
}


