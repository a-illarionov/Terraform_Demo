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

# Everything below is for the module

variable "subnet_prefix" {
  description = "address prefix for subnet"
  default     = ""
}

variable "vnet_name" {
  description = "Name of the vnet to create the subnets in"
  default     = ""
}

variable "subnets" {
  type        = list(any)
  description = "The address prefix to use for the subnet."
  default     = []
}

variable "add_endpoint" {
  description = "should we be adding an endpint, leave this as is"
  default     = false
}