output "storage_account_name" {
  description = "Le nom du compte de stockage"
  value = azurerm_storage_account.storage_account.name
}

output "storage_container_name" {
  description = "Le nom du conteneur Docker"
  value = azurerm_storage_container.storage_container.name
}

output "storage_blob_name" {
  description = "Le nom du blob storage"
  value = azurerm_storage_blob.blob_storage.name
}

output "storage_url" {
  description = "L'URL du blob storage"
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "storage_account_id" {
  description = "L'ID du compte de stockage"
  value = azurerm_storage_account.storage_account.id
}

