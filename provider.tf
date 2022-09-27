# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}

#Terraform setting value to subscription ID

provider "azurerm" {
  features {

  }
  subscription_id = var.subscription_id
}
