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

#Key Vault Module - retrieve password from key vault 
module "KeyVaultSecrets" {
  source  = "./Modules/KeyVault"
  kv      = var.kv
  secrets = var.secrets
}

#Networking Modules
module "vnet" {
  source              = "./Modules/VNets"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  environment         = var.environment
  vnet_name           = "vnet-${var.location}-${azurerm_resource_group.main.name}"
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
      name   = "subnet-${var.location}-${azurerm_resource_group.main.name}"
      prefix = "${var.subnets}"
    }
  ]
}
#Virtual Machines Module
module "windowsserver" {
  source              = "./Modules/VM"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  environment         = var.environment
  vm_sku              = var.vm_sku
  subnet_id           = module.subnet.vnet_subnets
  mysecret            = module.KeyVaultSecrets.mysecret
  source_ip           = var.source_ip
  capacity            = var.capacity
  tags                = merge(local.common_tags, local.extra_tags)
}
#Vnet peering module
module "vnet_peering" {
  source                    = "./Modules/VNetPeering"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.main.name
  environment               = var.environment
  vnet_name                 = module.vnet.vnet_name
  resource_group_hub        = module.networkhub.resource_group_hub
  hub_vnet                  = module.networkhub.hub_vnet_name
  remote_virtual_network_id = module.vnet.vnet_id
  hub_virtual_network_id    = module.networkhub.hub_vnet_id
}
