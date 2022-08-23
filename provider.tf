terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.17.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "573fc463-a743-481f-8688-28a35876fa68"
  tenant_id       = "745961a7-d85f-426e-bd60-5485597f872c"
}
