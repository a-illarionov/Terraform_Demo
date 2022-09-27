#assign variable subscription id
variable "subscription_id" {
  type        = string
  default     = ""
  description = "Enter your subscription here"
}

#assigning prefix naming
variable "environment" {
  description = "Name prefix for created resources"
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group we want to use"
  default     = ""
}

variable "location" {
  description = "location to create resource"
  default     = ""
}

# Everything below is for the module
variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = ""
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  default     = ""
}
variable "tags" {
  default = {}
}