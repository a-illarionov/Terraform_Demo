output "vnet_peering" {
  description = "outputs VNet peering for modules"
  value       = azurerm_virtual_network_peering.main
}