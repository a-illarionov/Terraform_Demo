#Create Virtual Machine
resource "azurerm_windows_virtual_machine" "main" {
  name                  = "${var.environment}-VM-${count.index}"
  location              = var.location
  count                 = var.capacity
  resource_group_name   = var.resource_group_name
  size                  = var.vm_sku
  admin_username        = "user.admin"
  admin_password        = var.mysecret
  tags                  = var.tags
  network_interface_ids = [azurerm_network_interface.internal[count.index].id]
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
#Custom script to install IIS on all VMS
resource "azurerm_virtual_machine_extension" "IISInstall" {
  name                 = "hostname"
  virtual_machine_id   = element(azurerm_windows_virtual_machine.main.*.id, count.index)
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  count                = var.capacity

  settings = <<SETTINGS
    {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf.rendered)}')) | Out-File -filepath install-iis.ps1\" && powershell -ExecutionPolicy Unrestricted -File install-iis.ps1"
  }
  SETTINGS
  tags = {
    environment = var.environment
  }
}

data "template_file" "tf" {
  template = file("./Modules/VM/install-iis.ps1")
}

#Create Network Security Group 
resource "azurerm_network_security_group" "main" {
  name                = "${var.environment}-NSG"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_RDP"
    description                = "allow RDP access"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.source_ip
    destination_address_prefix = "*"
  }

}
resource "azurerm_network_interface" "internal" {
  name                = "${var.environment}-${count.index}-int-nic"
  resource_group_name = var.resource_group_name
  location            = var.location
  count               = var.capacity
  tags = {
    nictype = "internal"
  }

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
#Create NSG association 
resource "azurerm_network_interface_security_group_association" "main" {
  count                     = var.capacity
  network_interface_id      = azurerm_network_interface.internal[count.index].id
  network_security_group_id = azurerm_network_security_group.main.id
}
#Configure auto shutdown for cost management
resource "azurerm_dev_test_global_vm_shutdown_schedule" "main" {
  virtual_machine_id = azurerm_windows_virtual_machine.main[count.index].id
  location           = var.location
  count              = var.capacity
  enabled            = true

  daily_recurrence_time = "1900"
  timezone              = "Pacific Standard Time"
  notification_settings {
    enabled         = true
    time_in_minutes = "60"
    webhook_url     = "https://sample-webhook-url.example.com"
  }
}

