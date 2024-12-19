Here is a basic example of how you might set up these resources using Terraform. This is a simplified example and does not include all possible configurations and options. You should adjust this to fit your specific needs.

```hcl
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "West Europe"
}

# Create an App Service Plan
resource "azurerm_app_service_plan" "plan" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "B2s"
  }
}

# Create an App Service
resource "azurerm_app_service" "app" {
  name                = "myAppService"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}

# Create a CosmosDB account
resource "azurerm_cosmosdb_account" "db" {
  name                = "myCosmosDBAccount"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
}

# Create a Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Create a CDN profile
resource "azurerm_cdn_profile" "cdn" {
  name                = "myCDNProfile"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

# Create a CDN endpoint
resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "myCDNEndpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  profile_name        = azurerm_cdn_profile.cdn.name
  origin_host_header  = azurerm_app_service.app.default_site_hostname
}

# Create an Azure Function
resource "azurerm_function_app" "function" {
  name                       = "myFunctionApp"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.plan.id
  storage_connection_string  = azurerm_storage_account.storage.primary_connection_string
}
```

This code creates a resource group, an App Service Plan with a B2s instance, an App Service, a CosmosDB account, a Storage Account, a CDN profile and endpoint, and a Function App. The CDN endpoint uses the App Service's default hostname as its origin. The Function App uses the Storage Account for its connection string.