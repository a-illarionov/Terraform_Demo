data "azurerm_key_vault_secret" "mysecret" {
  name         = var.secrets
  key_vault_id = var.kv
}