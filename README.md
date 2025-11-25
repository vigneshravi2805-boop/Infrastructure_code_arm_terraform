# Azure Infrastructure with Terraform

This Terraform configuration creates Azure infrastructure following best practices with modular design.

## Architecture

This project creates:
- **Resource Group**: Container for all resources
- **Virtual Network (VNet)**: Network infrastructure with subnets
- **Storage Account**: Hosts blob containers (public read) and the static website for your React build

## Module Structure

```
.
├── dev/                    # Development environment
│   ├── main.tf             # Environment configuration
│   ├── variables.tf        # Environment variables
│   ├── outputs.tf          # Environment outputs
│   ├── versions.tf         # Provider version requirements
│   └── terraform.tfvars.example # Example variable values
└── modules/                # Reusable modules
    ├── resource-group/
    ├── vnet/
    └── storage-account/
```

## Prerequisites

1. **Azure CLI** installed and configured
   ```bash
   az login
   az account set --subscription "b8dc426f-c0b7-4335-8dc7-5c4d17d36e52"
   ```

2. **Terraform** installed (version >= 1.0)
   - Download from [terraform.io](https://www.terraform.io/downloads)

## Quick Start

1. **Navigate to the dev environment folder:**
   ```bash
   cd dev
   ```

2. **Copy the example variables file:**
   ```bash
   copy terraform.tfvars.example terraform.tfvars
   ```

3. **Edit `terraform.tfvars` with your values:**
   - Update `resource_group_name`
   - Update `location` (Azure region)
   - Customize other variables as needed

4. **Initialize Terraform:**
   ```bash
   terraform init
   ```

5. **Review the execution plan:**
   ```bash
   terraform plan
   ```

6. **Apply the configuration:**
   ```bash
   terraform apply
   ```

7. **Destroy resources (when done):**
   ```bash
   terraform destroy
   ```

## Configuration

### Resource Group

The resource group module creates a container for all Azure resources.

**Variables:**
- `name`: Name of the resource group
- `location`: Azure region
- `tags`: Tags to apply

### Virtual Network

The VNet module creates:
- Virtual network with configurable address space
- Multiple subnets with configurable address prefixes
- Network Security Groups (NSG) for each subnet
- Default security rules (SSH on port 22, RDP on port 3389)

**Variables:**
- `vnet_name`: Name of the virtual network
- `address_space`: VNet address space (e.g., ["10.0.0.0/16"])
- `subnets`: Map of subnets with their configurations

**Example subnet configuration:**
```hcl
subnets = {
  subnet1 = {
    address_prefixes = ["10.0.1.0/24"]
    service_endpoints = []
  }
}
```

### Storage Account

The storage module creates:
- General-purpose v2 storage account (HTTPS enforced, TLS 1.2, system-assigned identity)
- Blob containers with configurable access (defaults to public read for blobs)
- Optional static website endpoint you can map to a custom domain via DNS

**Variables:**
- `storage_account`: Object with account name, replication tier, access tier, etc.
- `storage_containers`: Map of containers and their `access_type`

**Example:**
```hcl
storage_account = {
  name = "stdevtraining001" # must be globally unique
  static_website = {
    index_document = "index.html"
    error_document = "index.html"
  }
}

storage_containers = {
  appassets = { access_type = "private" }
}
```

## Outputs

After applying, Terraform will output:
- Resource group name and ID
- VNet ID and name
- Subnet IDs
- Storage account name and container IDs

Access outputs with:
```bash
terraform output
```

## Best Practices Implemented

✅ **Modular Design**: Separate modules for each resource type
✅ **Reusability**: Modules can be used independently or together
✅ **Security**: NSG rules, no hardcoded secrets
✅ **Tagging**: Consistent tagging strategy across all resources
✅ **Version Control**: Provider version pinning
✅ **State Management**: Proper state file handling (excluded from git)
✅ **Documentation**: Comprehensive README and inline comments
✅ **Flexibility**: Configurable through variables
✅ **Lifecycle Management**: Lifecycle rules for critical resources

## Security Considerations

1. **Never commit `terraform.tfvars`** - It may contain sensitive data
2. **Restrict NSG rules** - Limit inbound traffic to trusted IP ranges
3. **Use Azure Key Vault** for storing secrets in production
4. **Enable Azure Monitor** and logging for production workloads
5. **Audit VNet/subnet address spaces** to avoid overlap across environments

## Cost Optimization

- Remove unused dev resource groups to avoid idle charges (NSGs, public IPs, etc.)
- Keep VNet address spaces as small as practical to conserve IP space
- Reuse shared infrastructure (VNets/subnets) across workloads when appropriate

## Troubleshooting

### Authentication Issues
```bash
az login
az account list
az account set --subscription "subscription-id"
```

### Terraform State Issues
```bash
terraform refresh
terraform state list
```

### Networking Issues
- Verify NSG rules allow the expected traffic
- Check subnet address prefixes for overlaps
- Confirm service endpoints (if configured) are applied to the right subnets

## Additional Resources

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Virtual Network Documentation](https://docs.microsoft.com/azure/virtual-network/)

## License

This project is provided as-is for training purposes.

