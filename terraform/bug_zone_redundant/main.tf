terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # version = "3.24.0"  # requires zone_redundant when using Premium SKU, so there is no problem
      version = "=3.26.0"   # Starting in 3.25.0 does not require zone_redundant, defaults to False
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  type = string
  default = "westus3"
}

resource "azurerm_resource_group" "repro" {
  name     = "repro-eventhubs-premium"
  location = var.location
}

resource "azurerm_eventhub_namespace" "repro" {
  name                = "repro-eventhubs-premium"
  location            = azurerm_resource_group.repro.location
  resource_group_name = azurerm_resource_group.repro.name
  sku                 = "Premium"
  capacity            = 1

  # If you don't include, this, your namespace will be deleted if you are in a region with Availability Zones
  # zone_redundant      = true
}

resource "azurerm_eventhub" "hub1" {
  name                = "hub1"
  namespace_name      = azurerm_eventhub_namespace.repro.name
  resource_group_name = azurerm_eventhub_namespace.repro.resource_group_name
  partition_count     = 4
  message_retention   = 1
}
