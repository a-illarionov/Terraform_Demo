resource "azurerm_virtual_network_peering" "main" {
  name                         = "peering-to-${var.environment}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.vnet_name
  remote_virtual_network_id    = var.hub_virtual_network_id
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true

  #allow gateway transit must be set false for vnet Global peering
  allow_gateway_transit = false
}
#Peering to on-prem Vnet
resource "azurerm_virtual_network_peering" "rg" {
  name                         = "peering-to-${var.vnet_name}"
  resource_group_name          = var.resource_group_hub
  virtual_network_name         = var.hub_vnet
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true

  #allow gateway transit must be set false for vnet Global peering
  allow_gateway_transit = false
}