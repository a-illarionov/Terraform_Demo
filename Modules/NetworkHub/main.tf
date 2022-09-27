#Retrieve Resource Group data to peer with
data "azurerm_resource_group" "rg" {
  name = var.existingrg
}

#Retrieve vnet data from networking hub 
data "azurerm_virtual_network" "hub_vnet" {
  name                = var.existing_vnet
  resource_group_name = data.azurerm_resource_group.rg.name
}
