.
├── main.json         # ARM template
├── README.md         # This guide
└── parameters.json   # Optional parameters file


✅ Prerequisites

Before running the deployment, make sure you have:

Azure CLI installed
Download: https://learn.microsoft.com/cli/azure/install-azure-cli

Logged in to Azure

az login


A Resource Group created

az group create --name my-rg --location eastus

🚀 How to Deploy the ARM Template
Option 1: Deploy using parameters inline

az deployment group create --resource-group arm-rg --template-file main.json --parameters storageAccountName=mystoragarmdevenv45454 location=eastus

Option 2: Deploy using a parameters file

parameters.json

{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "storageAccountName": { "value": "mystorage12345" },
    "location": { "value": "eastus" }
  }
}


Run:

az deployment group create \
  --resource-group my-rg \
  --template-file main.json \
  --parameters @parameters.json

🌐 After Deployment
1. Upload your website files

Upload index.html, 404.html, JS, CSS, images into:

$web container


You can use Azure Portal or CLI:

az storage blob upload-batch \
  --account-name mystorage12345 \
  --destination '$web' \
  --source ./website-dist

2. Get the Static Website URL
az storage account show \
  --name mystorage12345 \
  --resource-group my-rg \
  --query "primaryEndpoints.web" \
  --output tsv


Output example:

https://mystorage12345.z29.web.core.windows.net/


Open in your browser to see your site running.

🧹 Cleanup (optional)

To delete everything:

az group delete --name my-rg --yes --no-wait