output "resource_group_name" {
  description = "Nom du groupe de ressources:"
  value = azurerm_resource_group.resource_group.name
}

output "resource_group_id" {
  description = "ID du groupe de ressources"
  value = azurerm_resource_group.resource_group.id
}

output "physical_location" {
  description = "Localisation du groupe de ressources:"
  value = azurerm_resource_group.resource_group.location
}

output "success_message_rg" {
  value = "Groupe de ressources créé avec succes."
}
