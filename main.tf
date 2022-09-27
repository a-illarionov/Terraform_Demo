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
#Create Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.environment}-rg-${var.location}"
  location = var.location
}

#Call modules

#existing resources
module "networkhub" {
  source = "./Modules/NetworkHub"

  existingrg    = var.existingrg
  existing_vnet = var.existing_vnet
}
#Key Vault Module
module "KeyVaultSecrets" {
  source = "./Modules/KeyVault"
  kv     = var.kv
}
#Networking Modules
module "vnet" {
  source              = "./Modules/Vnets"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  environment         = var.environment
  vnet_name           = "vnet-${var.location}-${azurerm_resource_group.main.name}-${var.environment}"
  address_space       = var.address_space
  tags                = merge(local.common_tags, local.extra_tags)
}

module "subnet" {
  source              = "./Modules/Subnets"
  resource_group_name = azurerm_resource_group.main.name
  environment         = var.environment
  location            = var.location
  vnet_name           = module.vnet.vnet_name

  subnets = [
    {
      name   = "subnet-${var.location}-${azurerm_resource_group.main.name}-${var.environment}"
      prefix = "${var.subnets}"
    }
  ]
}
#Virtual Machines Module
module "windowsserver" {
  source              = "./Modules/Virtual Machines"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  environment         = var.environment
  subnet_id           = module.subnet.vnet_subnets
  mysecret            = module.KeyVaultSecrets.mysecret
  source_ip           = var.source_ip
  capacity            = var.capacity
  tags                = merge(local.common_tags, local.extra_tags)
}
#Vnet peering module
module "vnet_peering" {
  source                    = "./Modules/Vnet Peering"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.main.name
  environment               = var.environment
  vnet_name                 = module.vnet.vnet_name
  resource_group_onprem     = module.networkhub.resource_group_hub
  on_prem_vnet              = module.networkhub.hub_vnet_name
  remote_virtual_network_id = module.vnet.vnet_id
  onprem_virtual_network_id = module.networkhub.hub_vnet_id
}
