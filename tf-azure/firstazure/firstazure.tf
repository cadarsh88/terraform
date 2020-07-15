provider "azurerm"{
    version = "~1.32.0"
    use_msi = true
    subscription_id = ""
    tenant_id = ""
}

resource "azurerm_resource_group" "resgroup"{
    name = "firstAzureTerraformResourceGroup"
    location = "eastus"
}