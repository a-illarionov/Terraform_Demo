output "mysecret" {
  value     = data.azurerm_key_vault_secret.mysecret.value
  sensitive = true
}