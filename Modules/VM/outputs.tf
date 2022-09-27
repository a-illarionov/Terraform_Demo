output "vm_name" {
  value = azurerm_windows_virtual_machine.main.*.name
}
output "nic_name" {
  value = azurerm_network_interface.internal.*.name
}