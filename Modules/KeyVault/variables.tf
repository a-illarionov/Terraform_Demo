variable "kv" {
  description = "key vault resource ID"
  type        = string
}
variable "secrets" {
  description = "Name of key vault secret to retrieve"
  default     = ""
}