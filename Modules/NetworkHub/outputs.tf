output "resource_group_hub" {
  value = data.azurerm_resource_group.rg.name
}
output "hub_vnet_id" {
  value = data.azurerm_virtual_network.hub_vnet.id
}
output "hub_vnet_name" {
  value = data.azurerm_virtual_network.hub_vnet.name
}