variable "environment" {
  description = "Name prefix for created resources"
  default     = ""
}
variable "resource_group_name" {
  description = "Enter Resource Group"
  default     = ""
}
variable "location" {
  description = "Enter Desired Azure Region"
  default     = ""
}

#Everything below is for modules 
variable "vnet_name" {
  description = "Name of the vnet to create the subnets in"
  default     = ""
}

variable "subnets" {
  description = "The address prefix to use for the subnet"
  default     = ""
}

variable "address_space" {
  default     = ""
  description = "VNet address space"
}

variable "vnet_id" {
  description = "VNet ID for peering Vnets"
  default     = ""
}
variable "subnet_id" {
  description = "Bring Subnet info"
  default     = ""
}
variable "resource_group_hub" {
  description = "Attaching on-prem resource group"
  default     = ""
}
variable "hub_vnet" {
  description = "import on-prem Vnet info"
  default     = ""
}
variable "remote_virtual_network_id" {
  description = "connect vnet id to newly created vnet"
  default     = ""
}
variable "hub_virtual_network_id" {
  description = "connect on prem vnet id"
  default     = ""
}
