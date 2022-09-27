variable "environment" {
  description = "Name prefix for created resources"
  default     = ""
}

variable "resource_group_name" {
  description = "Enter the resource group name"
  default     = ""
}

variable "location" {
  description = "region to create resource"
  default     = ""
}

# Everything below is for the module

variable "subnet_id" {
  description = ""
  default     = ""
}

variable "vm_sku" {
  description = "virtual machine sku"
  default     = ""
}

variable "capacity" {
  description = "Amount you'd like for count instance"
  default     = ""
}

variable "source_ip" {
  description = "Enter Source IP address"
  default     = ""
}

variable "mysecret" {
  description = "Grab Key Vault password"
  default     = ""
}

variable "tags" {
  default = {}
}