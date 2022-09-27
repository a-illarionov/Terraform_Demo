#assign variable subscription id
variable "subscription_id" {
  type        = string
  default     = ""
  description = "Enter your subscription here"
}
variable "kv" {
  description = "key vault resource ID"
  type        = string
}
variable "secrets" {
  description = "Name of key vault secret to retrieve"
  default     = ""
}
#assigning prefix naming
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
variable "capacity" {
  description = "amount of vms to be made"
  default     = ""
}
#Everything below is for modules 
variable "vnet_name" {
  description = "Name of the vnet to create the subnets in"
  default     = ""
}
variable "address_space" {
  default     = ""
  description = "VNet address space"
}

#variables for subnet
variable "subnets" {
  description = "The address prefix to use for the subnet"
  default     = ""
}

variable "vm_sku" {
  description = "virtual machine sku"
  default     = ""
}

#Key vault variable 
variable "mysecret" {
  description = "Grab Key Vault password"
  default     = ""
}

#variable for NSG inbound IP RDP rules
variable "source_ip" {
  description = "Enter Source IP address"
  default     = ""
}


#Netwokring hub variables
variable "resource_group_hub" {
  description = "Recieve data from existing resource group"
  default     = ""
}
variable "hub_vnet_name" {
  description = "hub vnet name import"
  default     = ""
}
variable "hub_virtual_network_id" {
  description = "connect hub vnet id"
  default     = ""
}
variable "hub_vnet" {
  description = "existing Vnet address space"
  default     = ""
}
variable "existingrg" {
  description = "Enter existing resource group to peer vnets"
  default     = ""
}
variable "existing_vnet" {
  description = "Existing Vnet Name"
  default     = ""
}
