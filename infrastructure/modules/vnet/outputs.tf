output "vnet_name" {
  description = "Nom du réseau virtuel"
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "ID du réseau virtuel"
  value = azurerm_virtual_network.vnet.id
}

output "database_subnet_name" {
  description = "Nom du sous-réseau"
  value = azurerm_subnet.database_subnet.name
}

output "database_subnet_id" {
  description = "ID du sous-réseau"
  value = azurerm_subnet.database_subnet.id
}

output "success_message_vnet" {
  value = "Réseau et sous-réseau virtuels créés avec succes"
}

output "app_subnet_id" {
  description = "ID du sous-réseau de l'App"
  value = azurerm_subnet.app_subnet.id
}

output "app_subnet_name" {
  description = "Nom du sous-réseau de l'App"
  value = azurerm_subnet.app_subnet.name
}

output "gateway_subnet_id" {
  description = "ID du gateway du sous-réseau"
  value = azurerm_subnet.gateway_subnet.id
}

output "gateway_subnet_name" {
  description = "Nom du gateway du sous-réseau"
  value = azurerm_subnet.gateway_subnet.name
}
